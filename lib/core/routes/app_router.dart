import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';
import 'package:substrack/feactures/auth/presentation/pages/login_page.dart';
import 'package:substrack/feactures/auth/presentation/pages/register_page.dart';
import 'package:substrack/feactures/subscriptions/presentation/pages/add_or_edit_page.dart';
import 'package:substrack/splash_page.dart';
import 'package:substrack/tabs_navigation.dart';

class AppRouter {
  final AuthBloc authBloc;

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouteRefreshStream(authBloc.stream),
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const TabNavigation()),
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/subscription',
        builder: (context, state) {
          final data = state.extra! as Map<String, dynamic>;
          final subscriptionToEdit = data['subscriptionToEdit'];
          final editPage = data['editPage'];

          return AddOrEditPage(
            subscriptionToEdit: subscriptionToEdit,
            editPage: editPage,
          );
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final authState = authBloc.state;

      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/register';
      final isGoingToSplash = state.matchedLocation == '/splash';
      final isPublicRoute =
          isGoingToLogin || isGoingToRegister || isGoingToSplash;

      // CASO A: Usuario NO autenticado (o estado inicial)
      if (authState is AuthInitial || authState is AuthUnauthenticated) {
        // Si no está logueado y NO va a una ruta pública, mandarlo al login.
        // Si YA está yendo a login o register, retornar null (dejarlo pasar).
        return isPublicRoute ? null : '/login';
      }

      // CASO B: Usuario Autenticado
      if (authState is AuthAuthenticated) {
        // Si está logueado pero intenta ver el Login o Registro,
        // redirigirlo al Home.
        if (isPublicRoute) {
          return '/';
        }
      }

      return null;
    },
  );

  AppRouter(this.authBloc);
}

class GoRouteRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouteRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
