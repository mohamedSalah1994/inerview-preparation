import 'package:flutter/material.dart';
import 'package:interview_preparation/features/auth/presentation/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:interview_preparation/core/services/theme_provider.dart';
import 'package:interview_preparation/core/utils/app_colors.dart';
import 'package:interview_preparation/features/auth/presentation/views/widgets/profile_view_body.dart';
import 'package:interview_preparation/features/tips/presentaion/views/tip_view.dart';

import '../../features/auth/presentation/manager/providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Toggle Dark Mode
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return ListTile(
                leading: const Icon(Icons.lightbulb),
                title: const Text('Toggle Dark Mode'),
                trailing: Switch(
                  activeColor: AppColors.primaryColor,
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (bool value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              );
            },
          ),
          // Navigate to Tips View
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Tips View'),
            onTap: () {
              Navigator.pushNamed(context, TipView.routeName);
            },
          ),
          // Navigate to Profile View
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile View'),
            onTap: () {
              Navigator.pushNamed(context, ProfileView.routeName);
            },
          ),
          // Logout Button
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              // Call the logout function from AuthProvider
              await Provider.of<AuthProvider>(context, listen: false).logout();

              // Optionally navigate to the login screen or show a message after logout
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, LoginView.routeName);  // Adjust the route to your login screen
            },
          ),
        ],
      ),
    );
  }
}
