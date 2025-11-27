import 'package:flutter/material.dart';

class TextButtomCustom extends StatelessWidget {
  final Widget text;
  final void Function()? onPressed;
  final bool loading;

  const TextButtomCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: loading ? null : onPressed, child: text);
  }
}
