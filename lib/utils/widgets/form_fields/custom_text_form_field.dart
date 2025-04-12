import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.keyboardType,
    this.labelText,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.onSaved,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final int? maxLines, maxLength;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        fillColor: fillColor,
        hintText: hintText,
        labelText: labelText ?? hintText,
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
      minLines: 1,
      onChanged: onChanged,
      maxLength: maxLength,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      readOnly: readOnly,
      focusNode: focusNode,
      textInputAction: textInputAction,
    );
  }
}
