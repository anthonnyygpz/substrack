import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/core/utils/global_error_traslator.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_in_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/user_entity.dart';
import 'package:substrack/feactures/auth/domain/repositories/iauth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<AppStarted>(_onAppStaterd);
    on<SignedUp>(_onSignUp);
    on<SignedIn>(_onSignIn);
    on<SignedOut>(_onSignOut);
    on<UserUpdated>(_onUserUpdated);
  }
  Future<void> _onAppStaterd(AppStarted event, Emitter<AuthState> emit) async {
    await emit.forEach<User?>(
      _authRepository.userChanges,
      onData: (user) {
        if (user != null) {
          return AuthAuthenticated(user: user);
        } else {
          return AuthUnauthenticated();
        }
      },
      onError: (error, stackTrace) {
        final friendlyMessage = GlobalErrorTranslator.translate(error);
        return AuthFailure(message: friendlyMessage);
      },
    );
  }

  void _onSignIn(SignedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final credentials = event.credentials;

    try {
      await _authRepository.signIn(credentials: credentials);
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(AuthFailure(message: friendlyMessage));
    }
  }

  Future<void> _onSignOut(SignedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(AuthFailure(message: friendlyMessage));
    }
  }

  void _onSignUp(SignedUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final newUser = event.newUser;

    try {
      final updatedUser = await _authRepository.signUp(newUser: newUser);
      if (updatedUser != null) {
        emit(AuthAuthenticated(user: updatedUser));
      }
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(AuthFailure(message: friendlyMessage));
    }
  }

  Future<void> _onUserUpdated(
    UserUpdated event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final user = event.user;
    try {
      final data = await _authRepository.updateUser(user: user);
      emit(AuthAuthenticated(user: data));
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(AuthFailure(message: friendlyMessage));
    }
  }
}
