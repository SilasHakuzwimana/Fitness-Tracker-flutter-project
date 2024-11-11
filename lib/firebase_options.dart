// ignore_for_file: unused_shown_name

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // Add other platforms if needed
    throw UnsupportedError(
      'DefaultFirebaseOptions are not configured for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC53a-q0pghfPNHBdya-wdroRLcjbeev7A',
    appId: '1:597332809734:web:40d7cf4ed5fa6ea3958b87', // Corrected for web
    messagingSenderId: '597332809734', // Use the correct sender ID
    projectId: 'fitness-tracker-66b10',
    authDomain: 'fitness-tracker-66b10.firebaseapp.com', // Corrected authDomain
    storageBucket: 'fitness-tracker-66b10.appspot.com', // Corrected storageBucket
  );
}
