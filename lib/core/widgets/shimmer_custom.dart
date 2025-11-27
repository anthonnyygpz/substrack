import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerCustom extends StatelessWidget {
  final Widget child;

  final double? width;
  final double? height;
  final bool? loading;
  final double? borderRadius;
  const ShimmerCustom({
    super.key,
    required this.child,
    this.width = 10.0,
    this.height = 10.0,
    this.loading = false,
    this.borderRadius = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return loading!
        ? ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius!),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Shimmer(
                enabled: loading!,
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: colorscheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                ),
              ),
            ),
          )
        : child;
  }
}
