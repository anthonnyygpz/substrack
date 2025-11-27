import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/utils/validators.dart';
import 'package:substrack/core/widgets/buttom_custom.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/core/widgets/text_form_field_custom.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';
import 'package:substrack/feactures/auth/presentation/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthBloc authBloc;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  void onSubmit() async {
    SnackBarCustom.loading(context, content: "Registrando el usuario...");
    try {
      authBloc.add(
        SignUpEvent(
          newUser: SignUpEntity(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            username: usernameController.text.trim(),
          ),
        ),
      );
      if (mounted) {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const LoginPage()),
        );
      }

      SnackBarCustom.success(context, content: "Registrado exitosamente!");
    } catch (e) {
      debugPrint(e.toString());
      SnackBarCustom.error(context);
    }
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              SnackBarCustom.loading(
                context,
                content: "Registrando nuevo usuario...",
              );
            }
            if (state is AuthErrorState) {
              SnackBarCustom.error(
                context,
                content: state.message ?? "Algo Salio mal al iniciar sesión",
              );
            }
            if (state is AuthAuthenticated) {
              SnackBarCustom.success(
                context,
                content: "Se registro exitosamente!",
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 0.0,
                ),
                child: Column(
                  children: [
                    Image.asset("assets/subtrackLogo.png"),

                    const Text(
                      "Registrarse",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Form(
                      child: Column(
                        spacing: 15,
                        children: [
                          TextFormFieldCustom(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: [AutofillHints.email],
                            validator: emailValidator,
                            label: const Text('Correo electronico'),
                            hintText: 'ejemplo@gmail.com',
                          ),

                          TextFormFieldCustom(
                            controller: passwordController,
                            passwordButton: true,
                            autofillHints: [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                            validator: passwordValidator,
                            label: const Text('Contraseña'),
                            hintText: '••••••••',
                          ),

                          TextFormFieldCustom(
                            controller: usernameController,
                            autofillHints: [AutofillHints.username],
                            keyboardType: TextInputType.text,
                            validator: requiredValidator,
                            label: const Text('Nombre de usuario'),
                            hintText: 'Juan123',
                          ),

                          ButtomCustom(onPressed: onSubmit, text: 'Registrase'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
