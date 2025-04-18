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
    apiKey: 'AIzaSyCkrMigZOh6hFQIdEfz23vvW9emf1o__c0',
    appId: '1:782223830267:web:571c07e78bffff859e945e',
    messagingSenderId: '782223830267',
    projectId: 'spotify-clone-6558c',
    authDomain: 'spotify-clone-6558c.firebaseapp.com',
    storageBucket: 'spotify-clone-6558c.firebasestorage.app',
    measurementId: 'G-EESJEFB0EX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzVTYCIJq2iiPY1mM5LwjERDUeYJazzgY',
    appId: '1:782223830267:android:f3c781b1c4a08d4d9e945e',
    messagingSenderId: '782223830267',
    projectId: 'spotify-clone-6558c',
    storageBucket: 'spotify-clone-6558c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUWthxT2PANo0TH3mkLDpsqHH5nUn71eQ',
    appId: '1:782223830267:ios:eb78f9a8a3dba9c69e945e',
    messagingSenderId: '782223830267',
    projectId: 'spotify-clone-6558c',
    storageBucket: 'spotify-clone-6558c.firebasestorage.app',
    iosBundleId: 'com.example.spotifyClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUWthxT2PANo0TH3mkLDpsqHH5nUn71eQ',
    appId: '1:782223830267:ios:eb78f9a8a3dba9c69e945e',
    messagingSenderId: '782223830267',
    projectId: 'spotify-clone-6558c',
    storageBucket: 'spotify-clone-6558c.firebasestorage.app',
    iosBundleId: 'com.example.spotifyClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkrMigZOh6hFQIdEfz23vvW9emf1o__c0',
    appId: '1:782223830267:web:c9f003afcbf0dcc39e945e',
    messagingSenderId: '782223830267',
    projectId: 'spotify-clone-6558c',
    authDomain: 'spotify-clone-6558c.firebaseapp.com',
    storageBucket: 'spotify-clone-6558c.firebasestorage.app',
    measurementId: 'G-YP004PJ3NR',
  );
}
