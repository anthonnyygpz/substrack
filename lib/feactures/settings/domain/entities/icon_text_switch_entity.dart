import 'package:flutter/cupertino.dart';

class IconTextEntity {
  final IconData icon;
  final String text;
  final Color? textColor;
  final Color? iconColor;
  final Color? bgIconColor;
  final void Function()? onTap;

  IconTextEntity({
    required this.icon,
    required this.text,
    this.textColor,
    this.iconColor,
    this.bgIconColor,
    required this.onTap,
  });
}
