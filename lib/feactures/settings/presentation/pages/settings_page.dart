import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/theme/colors.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/core/widgets/user_profile_card.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';
import 'package:substrack/feactures/profile/presentation/widgets/icon_text.dart';
import 'package:substrack/feactures/settings/domain/entities/icon_text_switch_entity.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void onLogout() async {
    context.read<AuthBloc>().add(SignOutEvent());
  }

  List<IconTextEntity> get _settingsOptions => [
    IconTextEntity(
      icon: Icons.question_answer,
      text: 'Contactar con soporte',
      onTap: null,
    ),
    IconTextEntity(
      icon: Icons.messenger,
      text: 'Contactar con soporte',
      onTap: null,
    ),
    IconTextEntity(
      icon: Icons.newspaper,
      text: 'Términos y condiciones',
      onTap: null,
    ),
    IconTextEntity(
      icon: Icons.shield,
      text: 'Política de privacidad',
      onTap: null,
    ),
    IconTextEntity(
      bgIconColor: AppColors.colorRedLight,
      textColor: AppColors.colorRedDark,
      iconColor: AppColors.colorRedDark,
      text: 'Cerrar sesión',
      icon: Icons.exit_to_app,
      onTap: () => onLogout(),
    ),
  ];

  Future<void> onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          SnackBarCustom.loading(context, content: "Cerrando sesión...");
        }

        if (state is AuthUnauthenticated) {
          SnackBarCustom.success(
            context,
            content: "Sesión cerrada exitosamente!",
          );
        }

        if (state is AuthErrorState) {
          SnackBarCustom.error(
            context,
            content:
                'Error al cerrar sesión: ${state.message ?? 'Algo salio mal al cerrar sesión'}',
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoadingState;
        final User? user = (state is AuthAuthenticated) ? state.user : null;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Ajustes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cuenta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      UserProfileCard(user: user, isLoading: isLoading),

                      SizedBox(height: 5),

                      const Text(
                        'Opciones',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      ..._settingsOptions.map(
                        (data) => IconText(
                          icon: data.icon,
                          text: data.text,
                          textColor: data.textColor,
                          bgIconColor: data.bgIconColor,
                          iconColor: data.iconColor,
                          onTap: data.onTap,
                        ),
                      ),
                    ],
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
