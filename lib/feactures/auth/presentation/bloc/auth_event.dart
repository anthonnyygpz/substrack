part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final SignUpEntity newUser;

  SignUpEvent({required this.newUser});
}

class SignInEvent extends AuthEvent {
  final SignInEntity credentials;

  SignInEvent({required this.credentials});
}

class AppStarted extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class FetchUserEvent extends AuthEvent {}
