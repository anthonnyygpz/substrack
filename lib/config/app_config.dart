import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/config/provider_config/bloc_provider.dart';
import 'package:substrack/config/provider_config/repository_provider.dart';

void appConfig({required Widget child}) {
  return runApp(
    MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(providers: blocProviders, child: child),
    ),
  );
}
