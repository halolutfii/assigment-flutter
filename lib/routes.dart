import 'package:flutter/material.dart';

import 'main.dart';
import 'screens/homescreen.dart';
import 'screens/editprofilescreen.dart';
import 'screens/addpotofolioscreen.dart';

class AppRoutes {
  static const String main = '/main';
  static const String home = '/home';
  static const String editProfile = '/edit-profile';
  static const String addPortfolio = '/add-portfolio';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case editProfile:
      //   return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case addPortfolio:
        return MaterialPageRoute(builder: (_) => AddPortfolioScreen());
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