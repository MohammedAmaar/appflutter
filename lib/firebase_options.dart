// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAUNAOOCmbCIMxjt_36TWgZKpV3owjMnGY',
    appId: '1:1060656109734:web:b3e4ee9cee8d7e40737c67',
    messagingSenderId: '1060656109734',
    projectId: 'myfirebase-c9a0a',
    authDomain: 'myfirebase-c9a0a.firebaseapp.com',
    storageBucket: 'myfirebase-c9a0a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCievpidiiTVxjQ5Fx4yIgMjgPgey8Cfi4',
    appId: '1:1060656109734:android:96c9bc243e16679c737c67',
    messagingSenderId: '1060656109734',
    projectId: 'myfirebase-c9a0a',
    storageBucket: 'myfirebase-c9a0a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUNm2GZFfzGQuRc8pxVirCx_Oz291dd-0',
    appId: '1:1060656109734:ios:f0673a6eab63ebd0737c67',
    messagingSenderId: '1060656109734',
    projectId: 'myfirebase-c9a0a',
    storageBucket: 'myfirebase-c9a0a.appspot.com',
    iosBundleId: 'com.example.appflutter',
  );
}
