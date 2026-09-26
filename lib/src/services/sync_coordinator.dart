import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
      final isOnline = !results.contains(ConnectivityResult.none);
      if (isOnline) {
        synchronize();
      } else {
        debugPrint('Offline');
      }
    });

    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        synchronize();
      } else {
        debugPrint('Disconnected');
      }
    });
  }

  Future<void> synchronize() {
    if (_runningSynchronization != null) {
      return _runningSynchronization!;
    }

    return _runningSynchronization = _syncService.synchronize().whenComplete(
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
