import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('Firebase is only configured for web.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA1QMfy51W65ugHLWo_Jbfm-fm9q9MdMos',
    authDomain: 'midnight-board-review-d2451.firebaseapp.com',
    projectId: 'midnight-board-review-d2451',
    storageBucket: 'midnight-board-review-d2451.firebasestorage.app',
    messagingSenderId: '831976152972',
    appId: '1:831976152972:web:c54fa413d0f10443e480a9',
  );
}
