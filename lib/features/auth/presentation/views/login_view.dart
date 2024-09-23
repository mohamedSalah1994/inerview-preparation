import 'package:flutter/material.dart';
import 'package:interview_preparation/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/firebase_auth_services.dart';
import '../../../../core/services/firestore_services.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/repos/auth_repo_impl.dart';
import '../manager/providers/auth_provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
                    create: (_) => AuthProvider(authRepo: AuthRepoImpl(authService: FirebaseAuthService(), databaseService: FireStoreService())),

        ),
      ],
      child: Scaffold(
        appBar: buildAppBar(context, title: 'Login'),
        body:  const LoginViewBody(),
      ),
    );
  }
}
