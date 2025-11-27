import 'package:flutter/material.dart';

class IconText extends StatefulWidget {
  final IconData icon;
  final Color? bgIconColor;
  final Color? iconColor;
  final String text;
  final Color? textColor;
  final void Function()? onTap;
  final bool? isLoading;

  const IconText({
    super.key,
    required this.icon,
    this.bgIconColor,
    this.iconColor,
    required this.text,
    this.textColor,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  State<IconText> createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.isLoading! ? null : widget.onTap,
      hoverColor: colorscheme.surfaceContainer.withValues(alpha: 0.5),
      splashColor: colorscheme.surfaceContainer.withValues(alpha: 0.7),
      highlightColor: colorscheme.surfaceContainer.withValues(alpha: 0.3),
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color:
                        widget.bgIconColor ??
                        colorscheme.surfaceContainerHighest,
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(widget.icon, color: widget.iconColor, size: 20),
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
