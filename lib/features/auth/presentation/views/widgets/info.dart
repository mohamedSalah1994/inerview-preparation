import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
    this.infoColor,
  });

  final String infoKey;
  final String info;
  final Color? infoColor;

  @override
  Widget build(BuildContext context) {
    // Determine the text color based on the theme if not provided
    final textColor = infoColor ?? Theme.of(context).textTheme.bodyLarge!.color!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: textColor.withOpacity(0.8),
            ),
          ),
          Text(
            info,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
