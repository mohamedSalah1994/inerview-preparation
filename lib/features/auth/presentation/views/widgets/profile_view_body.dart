import 'package:flutter/material.dart';
import 'package:interview_preparation/core/widgets/custom_button.dart';
import 'package:interview_preparation/features/auth/data/models/user_model.dart';
import 'package:interview_preparation/features/auth/presentation/views/widgets/profile_pic.dart';
import '../../../../../core/services/cache_services.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'info.dart';

class ProfileView extends StatelessWidget {
  final CacheService cacheService = CacheService();

  ProfileView({super.key});
  static const routeName = '/profile';

  Future<UserModel?> getUserData() async {
    return await cacheService.getCachedUserData();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode to adjust colors accordingly
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: buildAppBar(
        context,
        title: 'Profile',
        
      ),
      body: FutureBuilder<UserModel?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading profile data"));
          } else if (snapshot.data == null) {
            return const Center(child: Text("No user data available"));
          } else {
            final user = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const ProfilePic(image: "https://i.postimg.cc/cCsYDjvj/user-2.png"),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                  ),
                  const Divider(height: 32),
                  Info(
                    infoKey: "Email",
                    info: user.email,
                    infoColor: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                  Info(
                    infoKey: "Phone Number",
                    info: '0123456789',
                    infoColor: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 160,
                      child: CustomButton(
                        onPressed: () {},
                        text: 'Edit Profile',
                       
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
