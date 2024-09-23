import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_preparation/core/helper_functions/on_generate_route.dart';
import 'package:interview_preparation/features/auth/presentation/manager/providers/auth_provider.dart';
import 'package:interview_preparation/features/auth/presentation/views/login_view.dart';
import 'package:interview_preparation/features/home/presentation/manager/question_provider.dart';
import 'package:interview_preparation/features/tips/presentaion/manager/tip_provider.dart';
import 'package:interview_preparation/firebase_options.dart';
import 'package:provider/provider.dart';
import 'core/services/firebase_auth_services.dart';
import 'core/services/firestore_services.dart';
import 'core/services/theme_provider.dart';
import 'features/auth/data/repos/auth_repo_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
              authRepo: AuthRepoImpl(
                  authService: FirebaseAuthService(),
                  databaseService: FireStoreService())),
        ),
        ChangeNotifierProvider(
          create: (_) => TipProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: LoginView.routeName,
    );
  }
}
