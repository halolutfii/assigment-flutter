import 'package:flutter/material.dart';

import 'main.dart';
import 'screens/auth/splashscreen.dart';
import 'screens/homescreen.dart';
import 'screens/auth/loginscreen.dart';
import 'screens/editprofilescreen.dart';
import 'screens/addpotofolioscreen.dart';

class AppRoutes {
  static const String main = '/main';
  static const String splashscreen = '/splashscreen';
  static const String home = '/home';
  static const String login = '/login';
  static const String editProfile = '/edit-profile';
  static const String addPortfolio = '/add-portfolio';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case splashscreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case addPortfolio:
        return MaterialPageRoute(builder: (_) => AddPortfolioScreen());
      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}