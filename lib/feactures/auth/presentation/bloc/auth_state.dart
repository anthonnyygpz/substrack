part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String? message;

  AuthErrorState({required this.message});
}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User? user;

  AuthAuthenticated({required this.user});
}
