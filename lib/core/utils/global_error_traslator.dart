import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/core/utils/firebase_auth_errors.dart';
import 'package:substrack/core/utils/firebase_firestore_errors.dart';

class GlobalErrorTranslator {
  static String translate(dynamic error) {
    if (error is FirebaseAuthException) {
      return FirebaseAuthErrorTranslator.translate(error);
    } else if (error is FirebaseException &&
        error.plugin == 'cloud_firestore') {
      return FirebaseFirestoreErrorTranslator.translate(error);
    }

    return 'Ocurrió un error inesperado.';
  }
}
