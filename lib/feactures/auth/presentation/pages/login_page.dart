import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/utils/validators.dart';
import 'package:substrack/core/widgets/buttom_custom.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/core/widgets/text_buttom_custom.dart';
import 'package:substrack/core/widgets/text_form_field_custom.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_in_entity.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';
import 'package:substrack/feactures/auth/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidenPassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onLogin() async {
    if (!formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      SignInEvent(
        credentials: SignInEntity(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      ),
    );

    TextInput.finishAutofillContext();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          SnackBarCustom.loading(context, content: "Iniciando sesión...");
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
            content: "Se inicio sesión exitosamente!",
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is AuthLoadingState;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 0.0,
                ),
                child: Column(
                  children: [
                    Image.asset("assets/subtrackLogo.png"),

                    const Text(
                      "SubTrack: \n Gestión de suscripciones",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Form(
                      key: formKey,
                      child: AutofillGroup(
                        child: Column(
                          spacing: 15,
                          children: [
                            TextFormFieldCustom(
                              controller: emailController,
                              enabled: !isLoading,
                              autofillHints: [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                              label: const Text('Correo electronico'),
                              hintText: "ejemplo@gmail.com",
                            ),
                            TextFormFieldCustom(
                              controller: passwordController,
                              autofillHints: [AutofillHints.password],
                              enabled: !isLoading,
                              passwordButton: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: passwordValidator,
                              label: const Text('Contraseña'),
                              hintText: "••••••••",
                            ),
                            ButtomCustom(
                              onPressed: onLogin,
                              loading: isLoading,
                              text: 'Iniciar Sesión',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿No tienes cuenta?"),
                TextButtomCustom(
                  loading: isLoading,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  text: const Text('Registrarse'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
