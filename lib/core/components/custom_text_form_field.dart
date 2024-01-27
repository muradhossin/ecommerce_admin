import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Function(String?)? validator;
  final double? borderRadius;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.onChanged,
    required
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator as String? Function(String?)?,
      controller: controller,
      key: key,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
          borderSide: BorderSide(color: context.theme.primaryColor.withOpacity(.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
          borderSide: BorderSide(color: context.theme.primaryColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
          borderSide: BorderSide(color: Colors.red),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
