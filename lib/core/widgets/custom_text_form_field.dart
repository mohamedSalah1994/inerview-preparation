import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.icon,
    required this.textInputType,
    this.obscureText = false,
    this.onSaved,
  });
  final String hintText;
  final Widget? icon;
  final TextInputType textInputType;
  final bool obscureText;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Field can't be empty";
        }
        return null;
      },
      onSaved: onSaved,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF9FAFA),
        hintText: hintText,
        hintStyle: TextStyles.bold13.copyWith(color: const Color(0xff949D9E)),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: icon
        ),
        suffixIconColor: const Color(0xffC9CECF),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          width: 1,
          color: Color(0xFFE6E9E9),
        ));
  }
}
