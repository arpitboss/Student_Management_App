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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCRSZhosWF_fy3jvAQyWEAcsgnEImmTX3s',
    appId: '1:6011635621:web:5824ba8a0148daca598a4c',
    messagingSenderId: '6011635621',
    projectId: 'student-management-app-b1e65',
    authDomain: 'student-management-app-b1e65.firebaseapp.com',
    storageBucket: 'student-management-app-b1e65.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKDSYCD4zg0cpq3P4AeGS3YpTHRNGSMPQ',
    appId: '1:6011635621:android:dd54b602cf52567f598a4c',
    messagingSenderId: '6011635621',
    projectId: 'student-management-app-b1e65',
    storageBucket: 'student-management-app-b1e65.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD40709wcxXAzJUVW9J_WnbFjHiNsR1XxQ',
    appId: '1:6011635621:ios:4b5ee2e22f08f653598a4c',
    messagingSenderId: '6011635621',
    projectId: 'student-management-app-b1e65',
    storageBucket: 'student-management-app-b1e65.appspot.com',
    iosBundleId: 'com.example.studentManagementApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD40709wcxXAzJUVW9J_WnbFjHiNsR1XxQ',
    appId: '1:6011635621:ios:4b5ee2e22f08f653598a4c',
    messagingSenderId: '6011635621',
    projectId: 'student-management-app-b1e65',
    storageBucket: 'student-management-app-b1e65.appspot.com',
    iosBundleId: 'com.example.studentManagementApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCRSZhosWF_fy3jvAQyWEAcsgnEImmTX3s',
    appId: '1:6011635621:web:3bdd7d2b0ba1ae97598a4c',
    messagingSenderId: '6011635621',
    projectId: 'student-management-app-b1e65',
    authDomain: 'student-management-app-b1e65.firebaseapp.com',
    storageBucket: 'student-management-app-b1e65.appspot.com',
  );
}