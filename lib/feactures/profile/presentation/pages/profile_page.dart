import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:substrack/core/widgets/avatar_custom.dart';
import 'package:substrack/core/widgets/buttom_custom.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/core/widgets/text_form_field_custom.dart';
import 'package:substrack/feactures/auth/domain/entities/user_entity.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController photoUrlController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _hasChanges = false;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    photoUrlController.addListener(_checkForChanges);
    passwordController.addListener(_checkForChanges);
    usernameController.addListener(_checkForChanges);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthBloc>().state;
      if (state is AuthAuthenticated) {
        setState(() {
          _currentUser = state.user;
          photoUrlController.text = state.user?.photoURL ?? '';
          usernameController.text = state.user?.displayName ?? '';
        });
        _checkForChanges();
      }
    });
  }

  @override
  void dispose() {
    photoUrlController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void _checkForChanges() {
    final currentPhoto = photoUrlController.text.trim();
    final currentName = usernameController.text.trim();
    final currentPass = passwordController.text;

    final originalPhoto = _currentUser?.photoURL ?? '';
    final originalName = _currentUser?.displayName ?? '';

    bool photoChanged = currentPhoto != originalPhoto;

    bool nameChanged = currentName != originalName;

    bool passChanged = currentPass.isNotEmpty;

    final bool shouldActive = photoChanged || nameChanged || passChanged;

    if (_hasChanges != shouldActive) {
      setState(() {
        _hasChanges = shouldActive;
      });
    }
  }

  void onSubmit() {
    if (!formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      UserUpdated(
        user: UpdateUserEntity(
          username: usernameController.text.trim(),
          photoUrl: photoUrlController.text.trim(),
          password: passwordController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          if (_currentUser?.uid != state.user?.uid) {
            _currentUser = state.user;
            photoUrlController.text = state.user?.photoURL ?? '';
            usernameController.text = state.user?.displayName ?? '';
            _checkForChanges();
          }

          SnackBarCustom.success(
            context,
            content: "Se actualizaron los datos exitosamente!",
          );

          context.pop();
        }
        if (state is AuthLoading) {
          SnackBarCustom.loading(context, content: 'Actualizando...');
        }

        if (state is AuthFailure) {
          SnackBarCustom.error(
            context,
            content:
                state.message ??
                'Algo salio mal al actualizar los datos del usuario',
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;
        final User? user = (state is AuthAuthenticated) ? state.user : null;

        return Scaffold(
          appBar: AppBar(title: Text('Perfil'), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: formKey,
                child: AutofillGroup(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        SizedBox(height: 20),
                        AvatarCustom(
                          photoUrl: photoUrlController.text.trim(),
                          width: 100,
                          height: 100,
                          iconSize: 80,
                        ),
                        Text(
                          user?.displayName ?? 'Usuario',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          user?.email ?? 'Usuario',
                          style: TextStyle(
                            color: colorscheme.onSecondary,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 10),

                        TextFormFieldCustom(
                          controller: photoUrlController,
                          autofillHints: [AutofillHints.url],
                          hintText: 'https://www...',
                          label: const Text('URL del la imagen'),
                        ),

                        TextFormFieldCustom(
                          controller: usernameController,
                          autofillHints: [AutofillHints.username],
                          hintText: 'Usuario123',
                          label: const Text('Nombre de usuario'),
                        ),

                        TextFormFieldCustom(
                          obscureText: true,
                          passwordButton: true,
                          controller: passwordController,
                          autofillHints: [AutofillHints.password],
                          hintText: '••••••••',
                          label: const Text('Contraseña'),
                        ),

                        ButtomCustom(
                          enabled: _hasChanges,
                          isLoading: isLoading,
                          text: 'Actualizar',
                          onPressed: onSubmit,
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
