import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'observation_sync_service.dart';

class SyncCoordinator {
  SyncCoordinator({
    required this._syncService,
    Connectivity? connectivity,
    FirebaseAuth? auth,
  }) : _connectivity = connectivity ?? Connectivity(),
       _auth = auth ?? FirebaseAuth.instance;

  final ObservationSyncService _syncService;
  final Connectivity _connectivity;
  final FirebaseAuth _auth;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<User?>? _authSubscription;
  Future<void>? _runningSynchronization;
  bool _started = false;

  Future<void> start() async {
    if (_started) {
      return;
    }
    _started = true;

    await synchronize();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        synchronize();
      }
    });
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        synchronize();
      }
    });
  }

  Future<void> synchronize() {
    return _runningSynchronization ??= _syncService.synchronize().whenComplete(
      () {
        _runningSynchronization = null;
      },
    );
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _authSubscription?.cancel();
  }
}
