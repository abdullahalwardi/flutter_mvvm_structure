import 'package:app/common_lib.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({super.key, required this.controller, required this.onChanged, required this.onCountryCodeChanged});

  final ValueChanged<String?> onChanged;
  final TextEditingController controller;
  final ValueChanged<CountryCode> onCountryCodeChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: "77xxxxxxxxx",
      onChanged: onChanged,
      prefixIcon: CountryCodePicker(
        onChanged: onCountryCodeChanged,
        initialSelection: "IQ",
      ),
      validator: context.validator.phone().required().build(),
    );
  }
}
