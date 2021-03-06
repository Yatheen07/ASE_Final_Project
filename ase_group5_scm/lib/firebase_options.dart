// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAlu23G7q6bFl7G4p_be3M_UxgFWNo-8bg',
    appId: '1:717610476922:web:ed354ad3583b439e7422c3',
    messagingSenderId: '717610476922',
    projectId: 'sustainablecityase-7b01f',
    authDomain: 'sustainablecityase-7b01f.firebaseapp.com',
    databaseURL: 'https://sustainablecityase-7b01f-default-rtdb.firebaseio.com',
    storageBucket: 'sustainablecityase-7b01f.appspot.com',
    measurementId: 'G-WQPY8PR1JJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2DuOH3jtCKzevvHdjC64XAwLWK4g95Ec',
    appId: '1:717610476922:android:7b0b6ddd02b3cd467422c3',
    messagingSenderId: '717610476922',
    projectId: 'sustainablecityase-7b01f',
    databaseURL: 'https://sustainablecityase-7b01f-default-rtdb.firebaseio.com',
    storageBucket: 'sustainablecityase-7b01f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeVctnjnJ_VshEYQHdALhYlF_97KrTQD0',
    appId: '1:717610476922:ios:551006d0dbdf94a17422c3',
    messagingSenderId: '717610476922',
    projectId: 'sustainablecityase-7b01f',
    databaseURL: 'https://sustainablecityase-7b01f-default-rtdb.firebaseio.com',
    storageBucket: 'sustainablecityase-7b01f.appspot.com',
    iosClientId:
        '717610476922-flnvslhb1l73h468v0vm9r24fj85s34e.apps.googleusercontent.com',
    iosBundleId: 'com.asegroup5.aseGroup5Scm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCeVctnjnJ_VshEYQHdALhYlF_97KrTQD0',
    appId: '1:717610476922:ios:9c1f3dd18385e1137422c3',
    messagingSenderId: '717610476922',
    projectId: 'sustainablecityase-7b01f',
    databaseURL: 'https://sustainablecityase-7b01f-default-rtdb.firebaseio.com',
    storageBucket: 'sustainablecityase-7b01f.appspot.com',
    iosClientId:
        '717610476922-835kjueg928afd7noncnsnt5n12t3b31.apps.googleusercontent.com',
    iosBundleId: 'com.asegroup5.aseGroup5S',
  );
}
