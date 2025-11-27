import 'package:flutter/material.dart';

class AvatarCustom extends StatelessWidget {
  final String? photoUrl;
  final double? iconSize;
  final double? width;
  final double? height;

  const AvatarCustom({
    super.key,
    required this.photoUrl,
    this.iconSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return ClipRRect(
      child: ClipOval(
        child: photoUrl != null
            ? Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: colorscheme.primary,
                    width: width,
                    height: height,
                    child: Icon(
                      Icons.cancel,
                      color: colorscheme.onPrimary,
                      size: iconSize,
                    ),
                  );
                },
                photoUrl!,
                fit: BoxFit.cover,
                width: width,
                height: height,
              )
            : Container(
                color: colorscheme.primary,
                width: width,
                height: height,
                child: Icon(
                  Icons.person,
                  color: colorscheme.onPrimary,
                  size: iconSize,
                ),
              ),
      ),
    );
  }
}
