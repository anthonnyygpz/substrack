import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/feactures/auth/domain/repositories/iauth_repository.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';
import 'package:substrack/feactures/subscriptions/domain/repositories/isubcription_repository.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';

final blocProviders = [
  // Subscrptions
  BlocProvider<SubscriptionBloc>(
    create: (context) => SubscriptionBloc(
      subRepository: context.read<ISubscriptionRepository>(),
    ),
  ),

  // Auth
  BlocProvider<AuthBloc>(
    create: (context) =>
        AuthBloc(authRepository: context.read<IAuthRepository>())
          ..add(AppStarted()),
  ),
];
