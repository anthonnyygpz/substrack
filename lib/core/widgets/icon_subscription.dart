import 'package:flutter/material.dart';
import 'package:substrack/core/utils/firts_letter.dart';

class IconSubscription extends StatelessWidget {
  final Color dialogPickerColor;
  final String? valueFirstLetters;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderRadius;

  const IconSubscription({
    super.key,
    required this.dialogPickerColor,
    required this.valueFirstLetters,
    this.width = 45,
    this.height = 45,
    this.fontSize = 24,
    this.borderRadius = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: dialogPickerColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        boxShadow: [
          BoxShadow(
            color: dialogPickerColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            firstLetters(valueFirstLetters) ?? 'N/A',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: dialogPickerColor.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
