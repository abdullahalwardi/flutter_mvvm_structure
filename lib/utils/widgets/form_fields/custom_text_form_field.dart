import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.fillColor,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final int? maxLines, maxLength;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.outline,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      minLines: maxLines,
      onChanged: onChanged,
      maxLength: maxLength,
      obscureText: obscureText,
    );
  }
}
