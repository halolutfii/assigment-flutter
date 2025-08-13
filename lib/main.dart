import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/appbar.dart';
import 'widgets/drawer.dart';
import 'widgets/header.dart';
import 'screens/homescreen.dart';
import 'screens/profilescreen.dart';
import 'screens/portofolioscreen.dart';
import 'providers/profile_providers.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
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
      home: MainScreen(),
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
  final List<String> _titles = ['ESS Solecode', 'Profile Employee', 'Portofolio Employee'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_currentIndex],
        showDrawer: true, 
        onSettings: () {
            // aksi saat icon settings diklik
            print('Settings clicked');
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