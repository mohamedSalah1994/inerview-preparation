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
    // Determine colors based on the current theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final borderColor = isDarkMode ? const Color(0xFF3A3A3A) : const Color(0xFFE6E9E9);
    final fillColor = isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xffF9FAFA);
    final hintColor = isDarkMode ? const Color(0xffB0B0B0) : const Color(0xff949D9E);
    final suffixIconColor = isDarkMode ? const Color(0xffB0B0B0) : const Color(0xffC9CECF);

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
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyles.bold13.copyWith(color: hintColor),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: icon,
        ),
        suffixIconColor: suffixIconColor,
        border: buildBorder(borderColor),
        enabledBorder: buildBorder(borderColor),
        focusedBorder: buildBorder(borderColor),
      ),
    );
  }

  OutlineInputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }
}
