// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Retrieve variables from the loaded .env file
    final apiKey = dotenv.env['FIREBASE_API_KEY'];
    final authDomain = dotenv.env['FIREBASE_AUTH_DOMAIN'];
    final projectId = dotenv.env['FIREBASE_PROJECT_ID'];
    final storageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'];
    final messagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
    final appId = dotenv.env['FIREBASE_APP_ID'];
    final measurementId = dotenv.env['FIREBASE_MEASUREMENT_ID'];

    // Check to ensure variables loaded correctly
    if (apiKey == null ||
        authDomain == null ||
        projectId == null ||
        storageBucket == null ||
        messagingSenderId == null ||
        appId == null) {
      throw Exception('Failed to load Firebase credentials from .env file.');
    }

    // ✅ Removed `const`
    final FirebaseOptions webOptions = FirebaseOptions(
      apiKey: apiKey,
      authDomain: authDomain,
      projectId: projectId,
      storageBucket: storageBucket,
      messagingSenderId: messagingSenderId,
      appId: appId,
      measurementId: measurementId,
    );

    if (kIsWeb) {
      return webOptions;
    }

    // You can add specific options for Android/iOS here if needed.
    return webOptions;
  }
}
