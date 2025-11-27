import 'package:flutter/material.dart';

class SnackBarCustom {
  static void loading(BuildContext context, {String content = "Cargando..."}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // duration: const Duration(days: 365),
        content: Row(
          spacing: 10,
          children: [CircularProgressIndicator.adaptive(), Text(content)],
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
