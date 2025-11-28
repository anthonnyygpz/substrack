part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String? message;

  AuthFailure({required this.message});
}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User? user;

  AuthAuthenticated({required this.user});
}
