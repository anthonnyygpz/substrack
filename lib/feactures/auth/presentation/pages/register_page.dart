import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/utils/validators.dart';
import 'package:substrack/core/widgets/buttom_custom.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/core/widgets/text_form_field_custom.dart';
import 'package:substrack/feactures/auth/domain/entities/sign_up_entity.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onSubmit() async {
    if (!formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      SignedUp(
        newUser: SignUpEntity(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          username: usernameController.text.trim(),
        ),
      ),
    );
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
            if (state is AuthLoading) {
              SnackBarCustom.loading(
                context,
                content: "Registrando nuevo usuario...",
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
                      key: formKey,
                      child: AutofillGroup(
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

                            ButtomCustom(
                              onPressed: onSubmit,
                              text: 'Registrase',
                            ),
                          ],
                        ),
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
