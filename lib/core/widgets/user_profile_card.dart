import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/core/widgets/shimmer_custom.dart';
import 'package:substrack/feactures/profile/presentation/pages/profile_page.dart';

class UserProfileCard extends StatefulWidget {
  final User? user;
  final bool isLoading;

  const UserProfileCard({
    super.key,
    required this.user,
    required this.isLoading,
  });

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => pushScreen(context, screen: const ProfilePage()),
      onTapDown: (_) => setState(() {
        isPressed = true;
      }),
      onTapUp: (_) => setState(() {
        isPressed = false;
      }),
      onTapCancel: () => setState(() {
        isPressed = false;
      }),
      hoverColor: colorscheme.primary.withValues(alpha: 0.5),
      splashColor: colorscheme.primary.withValues(alpha: 0.7),
      highlightColor: colorscheme.primary.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 10,
          children: [
            ShimmerCustom(
              width: 40,
              height: 40,
              loading: widget.isLoading,
              child: ClipRect(
                child: ClipOval(
                  child: widget.user?.photoURL != null
                      ? Image.network(widget.user!.photoURL!, fit: BoxFit.cover)
                      : Container(
                          color: colorscheme.primary,
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.person,
                            color: colorscheme.onPrimary,
                          ),
                        ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerCustom(
                    width: 120,
                    height: 16,
                    loading: widget.isLoading,
                    child: Text(
                      "Bienvenido! ${widget.user?.displayName ?? 'Usuario'}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ShimmerCustom(
                    width: 180,
                    height: 14,
                    loading: widget.isLoading,
                    child: Text(
                      widget.user?.email ?? 'Sin correo electrónico',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorscheme.onSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
