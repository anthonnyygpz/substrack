import 'package:flutter/material.dart';

class IconTextButton extends StatefulWidget {
  final Icon icon;
  final Color? bgIconColor;
  final Widget text;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool isLoading;
  final MainAxisSize mainAxisSize;

  const IconTextButton({
    super.key,
    required this.icon,
    this.bgIconColor,
    required this.text,
    this.textColor,
    required this.onTap,
    this.isLoading = false,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  State<IconTextButton> createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    final bool isInteractive = widget.onTap != null && !widget.isLoading;

    return Opacity(
      opacity: isInteractive ? 1.0 : 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isInteractive ? widget.onTap : null,
        hoverColor: colorscheme.surfaceContainer.withValues(alpha: 0.5),
        splashColor: colorscheme.surfaceContainer.withValues(alpha: 0.7),
        highlightColor: colorscheme.surfaceContainer.withValues(alpha: 0.3),
        onTapDown: isInteractive
            ? (_) => setState(() {
                isPressed = true;
              })
            : null,
        onTapUp: isInteractive
            ? (_) => setState(() {
                isPressed = false;
              })
            : null,
        onTapCancel: isInteractive
            ? () => setState(() {
                isPressed = false;
              })
            : null,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            spacing: 10,
            mainAxisSize: widget.mainAxisSize,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      widget.bgIconColor ?? colorscheme.surfaceContainerHighest,
                ),
                padding: const EdgeInsets.all(6.0),
                child: widget.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: widget.bgIconColor,
                        ),
                      )
                    : widget.icon,
              ),
              widget.text,
            ],
          ),
        ),
      ),
    );
  }
}
