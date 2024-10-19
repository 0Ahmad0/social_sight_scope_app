import 'package:flutter/material.dart';
import 'package:social_sight_scope/app/screens/add_new_person_screen.dart';
import 'package:social_sight_scope/app/screens/chats_screen.dart';
import 'package:social_sight_scope/app/screens/contact_us_screen.dart';
import 'package:social_sight_scope/app/screens/forgot_password_screen.dart';
import 'package:social_sight_scope/app/screens/gemini_chat_screen.dart';
import 'package:social_sight_scope/app/screens/home_screen.dart';
import 'package:social_sight_scope/app/screens/login_screen.dart';
import 'package:social_sight_scope/app/screens/navbar_screen.dart';
import 'package:social_sight_scope/app/screens/send_messages_screen.dart';
import 'package:social_sight_scope/app/screens/setting_screen.dart';
import 'package:social_sight_scope/app/screens/show_person_details_screen.dart';
import 'package:social_sight_scope/app/screens/signup_screen.dart';
import 'package:social_sight_scope/app/screens/translation_screen.dart';

import '../../app/screens/face_detected_mode_screen.dart';
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
      case Routes.settingRoute:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
        );
      case Routes.contactUsRoute:
        return MaterialPageRoute(
          builder: (_) => ContactUsScreen(),
        );
      case Routes.chatRoute:
        return MaterialPageRoute(
          builder: (_) => ChatsScreen(),
        );
      case Routes.sendMessageRoute:
        return MaterialPageRoute(
          builder: (_) => SendMessagesScreen(),
        );
      case Routes.faceDetectionModeRoute:
        return MaterialPageRoute(
          builder: (_) => FaceDetectedModeScreen(),
        );
      case Routes.geminiChatRoute:
        return MaterialPageRoute(
          builder: (_) => GeminiChatScreen(),
        );
 case Routes.showPersonDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => ShowPersonDetailsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(child: Text('NO DATA')),
              ),
        );
    }
  }
}
