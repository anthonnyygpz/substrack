import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_in_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';

abstract class IAuthRepository {
  Future<void> signUp({required SignUpEntity newUser});
  Future<void> signIn({required SignInEntity credentials});
  Stream<User?> get userChanges;
  Future<bool> hasValidToken();
  Future<void> signOut();
}
