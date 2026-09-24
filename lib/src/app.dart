import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawtrol/src/shared/router/app_router.dart';

import 'providers/sync_provider.dart';

import 'settings/settings_controller.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(syncCoordinatorProvider.future).then((coordinator) {
      coordinator.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          restorationScopeId: 'app',

          supportedLocales: const [Locale('en', '')],

          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,

          routerConfig: appRouter,
        );
      },
    );
  }
}
