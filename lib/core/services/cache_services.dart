import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../features/auth/data/models/user_model.dart';

class CacheService {
  static const String _userDataKey = 'userData';

  // Save user data to SharedPreferences
  Future<void> cacheUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = jsonEncode(user.toMap());
    await prefs.setString(_userDataKey, userData);
  }

  // Get cached user data from SharedPreferences
  Future<UserModel?> getCachedUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return UserModel.fromJson(userData);
    }
    return null;
  }

  // Clear cached user data (optional for logout)
  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }
}
