part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignedUp extends AuthEvent {
  final SignUpEntity newUser;

  SignedUp({required this.newUser});
}

class SignedIn extends AuthEvent {
  final SignInEntity credentials;

  SignedIn({required this.credentials});
}

class AppStarted extends AuthEvent {}

class SignedOut extends AuthEvent {}

class UserUpdated extends AuthEvent {
  final UpdateUserEntity user;

  UserUpdated({required this.user});
}
