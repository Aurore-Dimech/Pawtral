import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/auth_provider.dart';
import '../providers/observation_workflow_provider.dart';
import '../providers/picture_provider.dart';
import '../services/observation_workflow_service.dart';
import '../services/picture_service.dart';

final scanControllerProvider = AsyncNotifierProvider<ScanController, ScanState>(
  ScanController.new,
);

class ScanState {
  const ScanState({this.picture, this.draft, this.isProcessing = false});

  final XFile? picture;
  final ObservationDraft? draft;
  final bool isProcessing;

  ScanState copyWith({
    XFile? picture,
    ObservationDraft? draft,
    bool? isProcessing,
    bool clearDraft = false,
  }) {
    return ScanState(
      picture: picture ?? this.picture,
      draft: clearDraft ? null : draft ?? this.draft,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class ScanController extends AsyncNotifier<ScanState> {
  late final PictureService _pictureService;

  ScanState? get _currentState => state.when(
    data: (value) => value,
    loading: () => null,
    error: (_, _) => null,
  );

  @override
  ScanState build() {
    _pictureService = ref.watch(pictureServiceProvider);
    return const ScanState();
  }

  Future<void> chooseFromGallery() async {
    final picture = await _pictureService.pickFromGallery();
    if (picture == null) {
      return;
    }

    state = AsyncData(
      (_currentState ?? const ScanState()).copyWith(
        picture: picture,
        clearDraft: true,
      ),
    );
  }

  Future<void> takePicture() async {
    final picture = await _pictureService.takePicture();
    if (picture == null) {
      return;
    }

    state = AsyncData(
      (_currentState ?? const ScanState()).copyWith(
        picture: picture,
        clearDraft: true,
      ),
    );
  }

  Future<ObservationDraft?> analyzePicture() async {
    final current = _currentState ?? const ScanState();
    final picture = current.picture;

    if (picture == null) {
      state = AsyncError(
        StateError('Choose or take a picture first.'),
        StackTrace.current,
      );
      return null;
    }

    if (ref.read(currentUserProvider) == null) {
      state = AsyncError(
        StateError('You must be logged in.'),
        StackTrace.current,
      );
      return null;
    }

    state = AsyncData(current.copyWith(isProcessing: true));

    try {
      final workflow = await ref.read(observationWorkflowProvider.future);
      final draft = await workflow.analyzePicture(picture: picture);
      state = AsyncData(current.copyWith(draft: draft, isProcessing: false));
      return draft;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }

  void reset() {
    state = const AsyncData(ScanState());
  }

  File? get selectedFile {
    final path = _currentState?.picture?.path;
    return path == null ? null : File(path);
  }
}
