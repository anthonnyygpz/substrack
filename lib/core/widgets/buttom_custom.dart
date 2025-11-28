import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final bool enabled;

  final double? fontSize;

  const ButtomCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.fontSize = 14,
    this.enabled = true,
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
        onPressed: (enabled && !isLoading) ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            if (isLoading)
              Transform.scale(
                scale: 0.5,
                child: CircularProgressIndicator.adaptive(),
              ),
            Text(
              !isLoading ? text : 'Cargando...',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
