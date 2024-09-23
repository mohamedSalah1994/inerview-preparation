import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:interview_preparation/features/auth/data/models/user_model.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../data/repos/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';
  bool _isLoading = false;
  String? _errorMessage;
  final AuthRepo authRepo;

  // Constructor to initialize AuthRepoImpl
  AuthProvider({required this.authRepo});

  // Getter for token
  String get token => _token;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Function to login with email and password
  Future<void> loginWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final result = await authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      result.fold((failure) {
        _errorMessage = failure.message;
      }, (user) async {
        final firebaseUser = FirebaseAuth.instance.currentUser;
        if (firebaseUser != null) {
          _token = await firebaseUser.getIdToken() ?? '';
        }
        _errorMessage = null;
      });
      notifyListeners();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  // Function to sign up with email and password
  Future<void> signUpWithEmail(String email, String password, String username) async {
    _setLoading(true);
    try {
      final result = await authRepo.createUserWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
      );
      result.fold((failure) {
        _errorMessage = failure.message;
      }, (user) async {
        final firebaseUser = FirebaseAuth.instance.currentUser;
        if (firebaseUser != null) {
          _token = await firebaseUser.getIdToken() ?? '';
        }
        _errorMessage = null;
      });
      notifyListeners();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  // Function to login with Google
  Future<void> loginWithGoogle() async {
    _setLoading(true);
    try {
      final result = await authRepo.signInWithGoogle();
      result.fold((failure) {
        _errorMessage = failure.message;
      }, (user) async {
        final firebaseUser = FirebaseAuth.instance.currentUser;
        if (firebaseUser != null) {
          _token = await firebaseUser.getIdToken() ?? '';
        }
        _errorMessage = null;
      });
      notifyListeners();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  // Function to add user data after signup
  Future<void> addUserData(UserModel userModel) async {
    try {
      await authRepo.addUserData(user: userModel);
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to logout
  Future<void> logout() async {
    _setLoading(true);
    try {
      await authRepo.logout();  // Call the logout method in FirebaseAuthService
      _token = '';
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  // Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Handle errors and set error messages
  void _handleError(dynamic e) {
    if (e is CustomException) {
      _errorMessage = e.message;
    } else {
      _errorMessage = 'An unknown error occurred.';
    }
    notifyListeners();
  }
}
