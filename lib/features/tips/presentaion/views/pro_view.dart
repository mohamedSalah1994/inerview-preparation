import 'package:flutter/material.dart';
import 'package:interview_preparation/core/utils/app_colors.dart';

class ProView extends StatelessWidget {
  final String itemName;

  const ProView({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Center(
        child: Hero(
          tag: itemName, // Use the item name as the hero tag
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                itemName,
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
