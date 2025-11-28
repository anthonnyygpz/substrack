import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_in_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<User?> signUp({required SignUpEntity newUser});
  Future<void> signIn({required SignInEntity credentials});
  Stream<User?> get userChanges;
  Future<void> signOut();
  Future<User?> updateUser({required UpdateUserEntity user});
}
