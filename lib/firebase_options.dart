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
    apiKey: 'AIzaSyA5tLFo2JYTOK2mtgAw2sDiPozaI-uN__E',
    appId: '1:587364165116:web:8b14a274559427e5cdfe79',
    messagingSenderId: '587364165116',
    projectId: 'todo-63dd8',
    authDomain: 'todo-63dd8.firebaseapp.com',
    storageBucket: 'todo-63dd8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAieU4iwT5Di3-O_uZTil1pe_WpsHSOzSI',
    appId: '1:587364165116:android:13ec8b03b592f850cdfe79',
    messagingSenderId: '587364165116',
    projectId: 'todo-63dd8',
    storageBucket: 'todo-63dd8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkjYeCJvZ4npWmC6bcQNmVwr_A2EN1M6I',
    appId: '1:587364165116:ios:f425c4caff0854c4cdfe79',
    messagingSenderId: '587364165116',
    projectId: 'todo-63dd8',
    storageBucket: 'todo-63dd8.firebasestorage.app',
    iosBundleId: 'com.example.todo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkjYeCJvZ4npWmC6bcQNmVwr_A2EN1M6I',
    appId: '1:587364165116:ios:f425c4caff0854c4cdfe79',
    messagingSenderId: '587364165116',
    projectId: 'todo-63dd8',
    storageBucket: 'todo-63dd8.firebasestorage.app',
    iosBundleId: 'com.example.todo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA5tLFo2JYTOK2mtgAw2sDiPozaI-uN__E',
    appId: '1:587364165116:web:aacd455607be3898cdfe79',
    messagingSenderId: '587364165116',
    projectId: 'todo-63dd8',
    authDomain: 'todo-63dd8.firebaseapp.com',
    storageBucket: 'todo-63dd8.firebasestorage.app',
  );
}