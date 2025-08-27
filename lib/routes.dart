import 'package:flutter/material.dart';

import 'screens/editprofilescreen.dart';
import 'screens/addpotofolioscreen.dart';

class AppRoutes {
  static const String editProfile = '/edit-profile';
  static const String addPortfolio = '/add-portfolio';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case addPortfolio:
        return MaterialPageRoute(builder: (_) => const AddPortfolioScreen());
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