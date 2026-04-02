import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('Firebase is only configured for web.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCARdLUq8yF5LmjNFoJPx3-2MLhNhd5q1Y',
    authDomain: 'midnight-board-review.firebaseapp.com',
    projectId: 'midnight-board-review',
    storageBucket: 'midnight-board-review.firebasestorage.app',
    messagingSenderId: '273298446603',
    appId: '1:273298446603:web:f95a07af8f2f62764fea0e',
    measurementId: 'G-134C24Z87B',
  );
}
