import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_in_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/user_entity.dart';
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
  Future<User?> signUp({required SignUpEntity newUser}) async {
    try {
      final phothoUrl = newUser.photoUrl;

      final data = await _fireAuth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: newUser.password,
      );

      if (data.user == null) {
        throw Exception('No se encontro los datos del usuario.');
      }

      await data.user!.updateDisplayName(newUser.username);

      if (phothoUrl != null && phothoUrl.isNotEmpty) {
        await data.user!.updatePhotoURL(newUser.photoUrl);
      }

      await data.user!.reload();

      return _fireAuth.currentUser;
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

  @override
  Future<User?> updateUser({required EditUserEntity user}) async {
    try {
      final password = user.password;
      final photoUrl = user.photoUrl;
      final username = user.username;

      final currentUser = _fireAuth.currentUser;
      if (currentUser == null) return null;

      if (username != null && username.isNotEmpty) {
        await currentUser.updateDisplayName(user.username);
        print('Actualizo username');
      }

      if (photoUrl != null && photoUrl.isNotEmpty) {
        await currentUser.updatePhotoURL(user.photoUrl);
        print('Actualizo foto');
      }

      if (password != null && password.isNotEmpty) {
        await currentUser.updatePassword(password);
        print('Actualizo contraseña');
      }
      return _fireAuth.currentUser;
    } catch (e) {
      rethrow;
    }
  }
}
