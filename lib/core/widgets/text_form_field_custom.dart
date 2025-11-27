import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? passwordButton;
  final Widget? label;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final bool? readOnly;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final String? initialValue;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatters;

  const TextFormFieldCustom({
    super.key,
    this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.validator,
    this.hintText,
    this.passwordButton = false,
    this.label,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.autofillHints,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
    this.initialValue,
    this.autofocus = false,
    this.inputFormatters,
  });

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  bool hidenPassword = true;

  void togglePassword() {
    setState(() {
      hidenPassword = !hidenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return TextFormField(
      autofocus: widget.autofocus!,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      initialValue: widget.initialValue,
      obscureText: widget.passwordButton! ? hidenPassword : false,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization!,
      autofillHints: widget.autofillHints,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      readOnly: widget.readOnly!,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: colorscheme.onSecondary),
        label: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.passwordButton!
            ? hidenPassword
                  ? IconButton(
                      onPressed: togglePassword,
                      icon: Icon(CupertinoIcons.eye),
                    )
                  : IconButton(
                      onPressed: togglePassword,
                      icon: Icon(CupertinoIcons.eye_slash),
                    )
            : null,
      ),
    );
  }
}
