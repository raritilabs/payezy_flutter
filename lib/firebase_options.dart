// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyDJaFlbsggFaOohW2V2HnSrPADs7SH2Gg4',
    appId: '1:6164723951:web:bbf957746186fbd4b7431a',
    messagingSenderId: '6164723951',
    projectId: 'devmode-payezy',
    authDomain: 'devmode-payezy.firebaseapp.com',
    storageBucket: 'devmode-payezy.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdEaxkHRFUzc8CqMa7qymCocMeb0swM_4',
    appId: '1:6164723951:android:58174f56f85278b7b7431a',
    messagingSenderId: '6164723951',
    projectId: 'devmode-payezy',
    storageBucket: 'devmode-payezy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUr3vPBxWda44NcgS9heVk0-FcIRwKhmg',
    appId: '1:6164723951:ios:50c9efe6431ca438b7431a',
    messagingSenderId: '6164723951',
    projectId: 'devmode-payezy',
    storageBucket: 'devmode-payezy.appspot.com',
    iosClientId: '6164723951-ot9jr06ihlrm7f3a88ellvgh4nrc1752.apps.googleusercontent.com',
    iosBundleId: 'com.example.payezy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUr3vPBxWda44NcgS9heVk0-FcIRwKhmg',
    appId: '1:6164723951:ios:c1166ef9645e9688b7431a',
    messagingSenderId: '6164723951',
    projectId: 'devmode-payezy',
    storageBucket: 'devmode-payezy.appspot.com',
    iosClientId: '6164723951-ggvofojl7va20o02it1hjucoa0mpudtn.apps.googleusercontent.com',
    iosBundleId: 'com.example.payezy.RunnerTests',
  );
}
