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
    apiKey: 'AIzaSyB4g8iZur-6uBma0rkdssegDwpNsmhDrvk',
    appId: '1:762015350510:web:25c98bb50282780322fdff',
    messagingSenderId: '762015350510',
    projectId: 'mynotes-app-84e85',
    authDomain: 'mynotes-app-84e85.firebaseapp.com',
    storageBucket: 'mynotes-app-84e85.appspot.com',
    measurementId: 'G-FZ7XJXF88X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMdeqmo8NeByX8vcLLJVOIIEGbbn0wDE4',
    appId: '1:762015350510:android:b676fcdd777e1a7622fdff',
    messagingSenderId: '762015350510',
    projectId: 'mynotes-app-84e85',
    storageBucket: 'mynotes-app-84e85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiJtNNkHlK8L3JigQOIf83NpBt7UWGt7c',
    appId: '1:762015350510:ios:c362d1f93c7ba34a22fdff',
    messagingSenderId: '762015350510',
    projectId: 'mynotes-app-84e85',
    storageBucket: 'mynotes-app-84e85.appspot.com',
    iosBundleId: 'com.nodomain.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiJtNNkHlK8L3JigQOIf83NpBt7UWGt7c',
    appId: '1:762015350510:ios:c362d1f93c7ba34a22fdff',
    messagingSenderId: '762015350510',
    projectId: 'mynotes-app-84e85',
    storageBucket: 'mynotes-app-84e85.appspot.com',
    iosBundleId: 'com.nodomain.mynotes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB4g8iZur-6uBma0rkdssegDwpNsmhDrvk',
    appId: '1:762015350510:web:6557dbd5cb21aa2422fdff',
    messagingSenderId: '762015350510',
    projectId: 'mynotes-app-84e85',
    authDomain: 'mynotes-app-84e85.firebaseapp.com',
    storageBucket: 'mynotes-app-84e85.appspot.com',
    measurementId: 'G-3DRM63WNNW',
  );
}
