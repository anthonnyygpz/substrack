import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreErrorTranslator {
  static String translate(dynamic error) {
    // Firestore lanza FirebaseException con el plugin 'cloud_firestore'
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'No tienes permisos para realizar esta acción.';
        case 'unavailable':
          return 'El servicio no está disponible temporalmente o no tienes conexión a internet.';
        case 'not-found':
          return 'No se encontró el documento solicitado.';
        case 'already-exists':
          return 'El registro ya existe.';
        case 'aborted':
          return 'La operación fue cancelada.';
        case 'deadline-exceeded':
          return 'El tiempo de espera se agotó. Inténtalo de nuevo.';
        case 'resource-exhausted':
          return 'Se ha excedido la cuota de uso o el espacio de almacenamiento.';
        case 'failed-precondition':
          // Esto suele pasar si falta un índice en Firestore o la consulta no es válida
          return 'Error en la operación (Requisito fallido). Contacta soporte.';
        case 'cancelled':
          return 'La operación fue cancelada por el usuario.';
        case 'data-loss':
          return 'Hubo una pérdida de datos irrecuperable.';
        case 'unknown':
          return 'Ocurrió un error desconocido en la base de datos.';
        default:
          return 'Error de base de datos: ${error.message}';
      }
    }

    // Si el error no es de Firebase
    return 'Ocurrió un error inesperado al acceder a los datos.';
  }
}
