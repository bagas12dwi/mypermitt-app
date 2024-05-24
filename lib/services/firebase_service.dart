import 'package:firebase_core/firebase_core.dart';
import 'package:permit_app/firebase_options.dart';

class FirebaseService {
  static Future<void> initializeApp() => Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}