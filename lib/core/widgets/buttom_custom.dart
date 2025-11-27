import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool loading;

  final double? fontSize;

  const ButtomCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorscheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: loading ? null : onPressed,
        child: Text(text, style: TextStyle(fontSize: fontSize)),
      ),
    );
  }
}
