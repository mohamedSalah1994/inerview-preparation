import 'package:flutter/material.dart';
import 'package:interview_preparation/features/home/presentation/views/home_view.dart';


import '../../features/auth/presentation/views/login_view.dart';

import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/auth/presentation/views/widgets/profile_view_body.dart';
import '../../features/tips/presentaion/views/tip_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());

    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    case ProfileView.routeName:
      return MaterialPageRoute(builder: (context) =>   ProfileView());

          case TipView.routeName:
      return MaterialPageRoute(builder: (context) =>   const TipView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
