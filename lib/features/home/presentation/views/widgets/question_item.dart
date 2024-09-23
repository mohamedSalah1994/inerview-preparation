import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isLargeScreen;
  final String heroTag;
  final VoidCallback onTap;

  const QuestionItem({
    Key? key,
    required this.question,
    required this.answer,
    required this.isLargeScreen,
    required this.heroTag,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check the current theme mode (dark or light)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        ),
        child: ListTile(
          title: Hero(
            tag: heroTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                question,
                style: TextStyle(
                  fontSize: isLargeScreen ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black, // Text color based on theme
                ),
              ),
            ),
          ),
          subtitle: Text(
            'Tap to see the answer',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[800], // Subtitle color based on theme
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[800], // Icon color based on theme
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
