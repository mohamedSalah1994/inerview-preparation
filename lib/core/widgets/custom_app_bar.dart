import 'package:flutter/material.dart';
import 'package:interview_preparation/core/services/theme_provider.dart';
import 'package:interview_preparation/core/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../utils/app_text_styles.dart';

AppBar buildAppBar(BuildContext context, {required String title}) {
  // Determine colors based on theme mode
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final iconColor = isDarkMode ? Colors.white : Colors.black;
  final titleColor = isDarkMode ? Colors.white : Colors.black;

  return AppBar(
    backgroundColor: isDarkMode ? Colors.black : Colors.white,
    elevation: 0,

    leading: Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer(); // Open the drawer
        },
        child: Icon(
          Icons.menu, // Menu icon
          color: iconColor,
        ),
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyles.bold19.copyWith(color: titleColor), // Set title color based on theme
    ),
    actions: [
      Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Switch(
            activeColor: AppColors.primaryColor,
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeProvider.toggleTheme(value);
            },
          );
        },
      ),
    ],
  );
}
