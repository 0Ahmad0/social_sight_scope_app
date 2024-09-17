import 'package:flutter/material.dart';
import 'package:social_sight_scope/app/screens/add_new_person_screen.dart';
import 'package:social_sight_scope/app/screens/forgot_password_screen.dart';
import 'package:social_sight_scope/app/screens/home_screen.dart';
import 'package:social_sight_scope/app/screens/login_screen.dart';
import 'package:social_sight_scope/app/screens/navbar_screen.dart';
import 'package:social_sight_scope/app/screens/signup_screen.dart';
import 'package:social_sight_scope/app/screens/translation_screen.dart';

import '../../app/screens/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.signUpRoute:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
        );
      case Routes.navbarRoute:
        return MaterialPageRoute(
          builder: (_) => NavbarScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case Routes.addNewPersonRoute:
        return MaterialPageRoute(
          builder: (_) => AddNewPersonScreen(),
        );
      case Routes.translationRoute:
        return MaterialPageRoute(
          builder: (_) => TranslationScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('NO DATA')),
          ),
        );
    }
  }
}
