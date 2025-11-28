import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/widgets/user_profile_card.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;
        final User? user = (state is AuthAuthenticated) ? state.user : null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: UserProfileCard(user: user, isLoading: isLoading),
            ),

            IconButton(
              onPressed: () {},
              icon: Badge(label: Text('1'), child: Icon(Icons.notifications)),
            ),
          ],
        );
      },
    );
  }
}
