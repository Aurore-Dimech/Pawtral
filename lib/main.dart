import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    // Force the debug provider on Android when running a debug build
    androidProvider: kDebugMode
        ? AndroidProvider.debug
        : AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.debug,
  );

  // var db = FirebaseFirestore.instance;

  // db
  //     .collection("jokes")
  //     .add({
  //       'setup': 'Why did the scarecrow win an award?',
  //       'punchline': 'Because he was outstanding in his field!',
  //       'type': 'general',
  //       'id': 1,
  //     })
  //     .then((DocumentReference doc) {
  //       print('Document added with ID: ${doc.id}');
  //     })
  //     .catchError((error) {
  //       print('Error adding document: $error');
  //     });

  // final model = FirebaseAI.googleAI().generativeModel(
  //   model: 'gemini-3.5-flash',
  // );

  // final prompt = [Content.text('Write a story about a magic backpack.')];

  // To generate text output, call generateContent with the text input
  // final response = await model.generateContent(prompt);
  // print(response.text);

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(ProviderScope(child: MyApp(settingsController: settingsController)));
}
