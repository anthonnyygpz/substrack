import 'package:flutter/cupertino.dart';

class IconTextEntity {
  final Icon icon;
  final Widget text;
  final Color? bgIconColor;
  final VoidCallback? onTap;

  IconTextEntity({
    required this.icon,
    required this.text,
    this.bgIconColor,
    required this.onTap,
  });
}
