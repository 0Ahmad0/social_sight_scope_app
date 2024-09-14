
import 'package:flutter/material.dart';

import '../../app/screens/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {

        case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
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
