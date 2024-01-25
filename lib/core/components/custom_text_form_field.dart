import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const CustomTextFormField({super.key, this.hintText, this.labelText, this.onChanged, required this.controller, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      key: key,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
