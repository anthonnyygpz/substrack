import 'package:flutter/material.dart';

class SnackBarCustom {
  static void loading(BuildContext context, {String content = "Cargando..."}) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorscheme.surfaceContainer,
        content: Row(
          spacing: 10,
          children: [
            Transform.scale(
              scale: 0.8,
              child: CircularProgressIndicator.adaptive(),
            ),
            Text(content, style: TextStyle(color: Colors.white)),
          ],
        ),
        dismissDirection: DismissDirection.none,
      ),
    );
  }

  static void success(
    BuildContext context, {
    String content = "Todo salio bien!",
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[300],
        content: Row(
          spacing: 10,
          children: [
            Icon(Icons.check_circle, color: Colors.green[700]),
            Text(content, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        showCloseIcon: true,
      ),
    );
  }

  static void error(
    BuildContext context, {
    String content = "Algo salio mal!",
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[300],
        content: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              Icon(Icons.nearby_error_sharp, color: Colors.red[700]),
              Text(content, style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        showCloseIcon: true,
      ),
    );
  }

  static void remove(
    BuildContext context, {
    String content = "Se elimino la suscripcion.",
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey,
        content: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              Icon(Icons.delete_outlined),
              Wrap(
                children: [
                  Text(content, style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
        showCloseIcon: true,
      ),
    );
  }
}
