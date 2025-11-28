import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorTranslator {
  static String translate(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'Este correo electrónico ya está registrado.';
        case 'invalid-email':
          return 'El correo electrónico no es válido.';
        case 'weak-password':
          return 'La contraseña es muy débil (mínimo 6 caracteres).';
        case 'user-not-found':
          return 'No se encontró ningún usuario con este correo.';
        case 'wrong-password':
          return 'Contraseña incorrecta.';
        case 'user-disabled':
          return 'Esta cuenta ha sido inhabilitada.';
        case 'too-many-requests':
          return 'Demasiados intentos fallidos. Inténtalo más tarde.';
        case 'operation-not-allowed':
          return 'Operación no permitida. Contacta soporte.';
        case 'network-request-failed':
          return 'Sin conexión a internet.';
        case 'credential-already-in-use':
          return 'Esta credencial ya está asociada a otra cuenta.';
        case 'invalid-credential':
          return 'Esta credenciales son incorrectas.';
        default:
          return 'Error de autenticación: ${error.message}';
      }
    }
    // Si el error no es de Firebase (ej: timeout, error de dart, etc)
    return 'Ocurrió un error inesperado. Inténtalo de nuevo.';
  }
}
