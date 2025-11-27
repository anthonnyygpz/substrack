import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kDebugMode;
import 'package:substrack/firebase_options.dart';

const useEmulator = true;
const databasePort = 9000;
const firestorePort = 8081;

Future<void> firebaseDB() async {
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseFirestore.instanceFor(app: app);
      FirebaseAuth.instanceFor(app: app);

      print("Esta en el dispositivo: $defaultTargetPlatform");
      print("✅ Conectado a Firebase.");
    } catch (e) {
      print(e);
    }
  }
}
