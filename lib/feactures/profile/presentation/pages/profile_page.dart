import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/widgets/avatar_custom.dart';
import 'package:substrack/core/widgets/text_form_field_custom.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController photoUrlController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repetPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bool isLoading = state is AuthLoadingState;
        final User? user = (state is AuthAuthenticated) ? state.user : null;

        return Scaffold(
          appBar: AppBar(title: Text('Perfil'), centerTitle: true),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: formKey,
                  child: AutofillGroup(
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 20),
                        AvatarCustom(
                          photoUrl: photoUrlController.text.trim(),
                          width: 100,
                          height: 100,
                          iconSize: 80,
                        ),
                        TextFormFieldCustom(
                          initialValue: user?.photoURL,
                          controller: photoUrlController,
                          autofillHints: [AutofillHints.url],
                          onChanged: (value) {
                            setState(() {
                              photoUrlController.text = value;
                            });
                          },
                          hintText: 'https://www...',
                          label: const Text('URL del la imagen'),
                        ),
                        TextFormFieldCustom(
                          controller: passwordController,
                          autofillHints: [AutofillHints.password],
                          hintText: '••••••••',
                          label: const Text('Contraseña'),
                        ),

                        TextFormFieldCustom(
                          controller: repetPasswordController,
                          hintText: '••••••••',
                          label: const Text('Repetir Contraseña'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
