import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_in_entity.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:substrack/feactures/auth/domain/repositories/iauth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitialState()) {
    on<AppStarted>(_appStaterd);
    on<SignUpEvent>(_signUp);
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
  }
  Future<void> _appStaterd(AppStarted event, Emitter<AuthState> emit) async {
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
        return AuthErrorState(message: error.toString());
      },
    );
  }

  void _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final newUser = event.newUser;

    try {
      await _authRepository.signUp(newUser: newUser);
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }

  void _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final credentials = event.credentials;

    try {
      await _authRepository.signIn(credentials: credentials);
      emit(AuthAuthenticated(user: null));
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }

  Future<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepository.signOut();
    } catch (e) {
      emit(AuthUnauthenticated());
      await Future.delayed(Duration(seconds: 3));
      emit(AuthErrorState(message: e.toString()));
    }
  }
}
