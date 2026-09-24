import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';

class AnimalAiService {
  AnimalAiService()
    : _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-3.6-flash');

  final GenerativeModel _model;

  Future<String> identifyAnimal(File image) async {
    final bytes = await image.readAsBytes();

    final response = await _model.generateContent([
      Content.multi([
        TextPart(
          'Identify the animal in this image. '
          'Return only the common English name. '
          'If there is no animal, return UNKNOWN.',
        ),
        InlineDataPart('image/jpeg', bytes),
      ]),
    ]);

    final result = response.text?.trim();

    if (result == null || result.isEmpty || result == 'UNKNOWN') {
      throw Exception('No animal could be identified.');
    }

    return result.toLowerCase();
  }
}