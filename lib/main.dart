import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/config/app_config.dart';
import 'package:substrack/config/firebase_db.dart';
import 'package:substrack/core/routes/app_router.dart';
import 'package:substrack/core/theme/theme_dark.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseDB();

  await initializeDateFormatting("es_ES", null);

  await findSystemLocale();

  appConfig(child: const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthBloc>();
    _appRouter = AppRouter(authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: themeDark, useMaterial3: true),
      builder: (context, child) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            return child!;
          },
        );
      },
    );
  }
}
