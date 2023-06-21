
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text(widget.label),
        hintText: widget.hintText,
        suffixIcon: isObscure? IconButton(onPressed: (){
          setState(() {
            isObscure = !isObscure;
          });
        }, icon: const Icon(Icons.visibility_off),
        ):  IconButton(onPressed: (){
          setState(() {
            isObscure = !isObscure;
          });
        }, icon: const Icon(Icons.visibility),
        ),
        ),
      obscureText: isObscure,
      validator: context.validator.required(context.l10n.validationRequired).build(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}