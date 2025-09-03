import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';
import 'widgets/drawer.dart';
import 'widgets/header.dart';

import 'screens/homescreen.dart';
import 'screens/profilescreen.dart';
import 'screens/portofolioscreen.dart';
import 'screens/auth/splashscreen.dart';

import 'providers/user_providers.dart';
import 'providers/portofolio_providers.dart';

import 'routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PortofolioProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: SplashScreen(),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() => _currentIndex = index);
  }
  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    PortofolioScreen(),
  ];
  final List<String> _titles = ['Home', 'Profile', 'Portofolio'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_currentIndex],
        showDrawer: true, 
        onSettings: () {   
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Settings Clicked!"),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
      drawer: AppDrawer(
        onItemTap: _changeTab,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2E3A59),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 213, 213, 213),
        onTap: _changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_history),
            label: 'Portofolio',
          ),
        ],
      ),
    );
  }
}