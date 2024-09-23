import 'package:flutter/material.dart';
import 'package:interview_preparation/core/services/firebase_auth_services.dart';
import 'package:interview_preparation/core/services/firestore_services.dart';
import 'package:interview_preparation/features/auth/data/repos/auth_repo_impl.dart';
import 'package:interview_preparation/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/providers/auth_provider.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(authRepo: AuthRepoImpl(authService: FirebaseAuthService(), databaseService: FireStoreService())),
        ),
      ],
      child: Scaffold(
        appBar: buildAppBar(context, title: 'Signup'),
        body: const SignupViewBody(),
      ),
    );
  }
}
