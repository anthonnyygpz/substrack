import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showRemoveDialog(
  BuildContext context, {
  required void Function()? onAccept,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminar'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [Text('¿Quieres borrar esta suscripción?')],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(onPressed: onAccept, child: const Text('Aceptar')),
        ],
      );
    },
  );
}
