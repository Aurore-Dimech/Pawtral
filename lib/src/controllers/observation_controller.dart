import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/local_observation_provider.dart';
import '../providers/observation_workflow_provider.dart';
import '../services/observation_workflow_service.dart';

final observationControllerProvider =
    AsyncNotifierProvider<ObservationController, void>(
      ObservationController.new,
    );

class ObservationController extends AsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> save(ObservationDraft draft) async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      state = AsyncError(
        StateError('You must be logged in.'),
        StackTrace.current,
      );
      return false;
    }

    state = const AsyncLoading();

    try {
      final workflow = await ref.read(observationWorkflowProvider.future);
      await workflow.saveDraft(draft: draft, userId: user.uid);
      ref.invalidate(localObservationsProvider(user.uid));
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
