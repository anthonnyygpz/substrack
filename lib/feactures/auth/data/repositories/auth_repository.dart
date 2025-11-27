import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_in_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';
import 'package:substrack/feactures/auth/domain/repositories/iauth_repository.dart';

class AuthRepository extends IAuthRepository {
  final FirebaseAuth _fireAuth;

  AuthRepository(this._fireAuth);

  @override
  Future<bool> hasValidToken() async {
    final user = _fireAuth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  @override
  Stream<User?> get userChanges => _fireAuth.authStateChanges();

  @override
  Future<void> signUp({required SignUpEntity newUser}) async {
    try {
      final data = await _fireAuth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: newUser.password,
      );

      if (data.user != null) {
        throw Exception('No se encontro los datos del usuario.');
      }

      data.user!.updateDisplayName(newUser.username);
      if (newUser.photoUrl != null) {
        data.user!.updatePhotoURL(newUser.photoUrl);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signIn({required SignInEntity credentials}) async {
    try {
      await _fireAuth.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _fireAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
