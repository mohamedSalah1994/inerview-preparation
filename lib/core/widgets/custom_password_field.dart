import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.onSaved,
  });
  final void Function(String?)? onSaved;
  
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
   bool obscureText = true;
  @override
  
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onSaved: widget.onSaved,
      hintText: 'Password',
      icon: GestureDetector(
        onTap: () {
         
          setState(() {
             obscureText = !obscureText;
          });
        },
        child: Icon(
            obscureText
                ? Icons.visibility
                : Icons.visibility_off,
                size: 32,
              ),
      ),
      textInputType: TextInputType.text,
      obscureText: obscureText,
    );
  }
}