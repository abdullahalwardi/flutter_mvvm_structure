import 'package:app/common_lib.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({super.key, required this.controller, required this.onChanged});

  final ValueChanged onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: "77xxxxxxxxx",
      onChanged: (value) {},
      prefixIcon: CountryCodePicker(
        onChanged: onChanged,
        initialSelection: "IQ",
      ),
      validator: context.validator.phone().required().build(),
    );
  }
}
