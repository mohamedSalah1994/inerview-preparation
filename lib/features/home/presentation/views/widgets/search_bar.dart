import 'package:flutter/material.dart';
import 'package:interview_preparation/core/utils/app_colors.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final ValueChanged<String> onChanged;

  const SearchBar({
    Key? key,
    required this.hintText,
    required this.borderColor,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
