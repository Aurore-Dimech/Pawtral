import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/sync_coordinator.dart';
import 'local_observation_provider.dart';

final syncCoordinatorProvider = FutureProvider<SyncCoordinator>((ref) async {
  final coordinator = SyncCoordinator(
    syncService: await ref.watch(observationSyncServiceProvider.future),
  );
  ref.onDispose(coordinator.dispose);
  return coordinator;
});
