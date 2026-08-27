import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBD623ndTKKu3AiQ96t9kqeC7erS7QDVEk',
    appId: '1:432646264994:android:c8728320108a6ffd0d9ffb',
    messagingSenderId: '432646264994',
    projectId: 'placefinderapp-66b57',
    storageBucket: 'placefinderapp-66b57.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDU_fM0TntOjxJ1YJq6YOnUvHU1oCDCohU',
    appId: '1:432646264994:ios:c94661ea26d3fb970d9ffb',
    messagingSenderId: '432646264994',
    projectId: 'placefinderapp-66b57',
    storageBucket: 'placefinderapp-66b57.firebasestorage.app',
    iosBundleId: 'com.example.placefinderapp',
  );
}
