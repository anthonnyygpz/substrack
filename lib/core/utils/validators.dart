import 'package:email_validator/email_validator.dart';

String? requiredValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }

  if (!EmailValidator.validate(value)) {
    return "Por favor de poner un correo valido.";
  }
  return null;
}

String? currencyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }

  final double? amount = double.tryParse(value);
  if (amount == null) {
    return 'Por favor, ingrese un número válido';
  }
  if (amount < 0) {
    return 'El monto no puede ser negativo';
  }
  return null;
}

String? numberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }

  final int? number = int.tryParse(value);

  if (number == null) {
    return 'Por favor, ingrese un número válido';
  }
  if (number < 0) {
    return 'El monto no puede ser ngativo';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }

  if (value.length < 8) {
    return "La contraseña debe tener al menos 8 caracteres";
  }
  return null;
}
