import 'package:flutter/material.dart';
import 'package:pawtrol/src/shared/router/app_router.dart';

import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          restorationScopeId: 'app',

          supportedLocales: const [
            Locale('en', ''), 
          ],

          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          routerConfig: appRouter,

        );
      },
    );
  }
}
