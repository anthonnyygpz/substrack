import 'package:flutter/material.dart';

class DropdownButtonFormFieldCustom extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final String? selectedOption;
  final List<String> options;
  final String? hintText;
  final bool isLoading;

  const DropdownButtonFormFieldCustom({
    super.key,
    required this.selectedOption,
    this.isLoading = false,
    required this.options,
    this.validator,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return DropdownButtonFormField(
      dropdownColor: colorscheme.surfaceContainer,
      disabledHint: Text('Cargando...'),
      hint: Text("$hintText"),
      initialValue: selectedOption,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: colorscheme.onSecondary),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: isLoading ? null : onChanged,
      validator: validator,
    );
  }
}
