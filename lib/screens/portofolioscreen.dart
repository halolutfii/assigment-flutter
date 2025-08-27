import 'package:flutter/material.dart';
import 'package:my_portofolio_app/routes.dart';

import 'tabs/all_tab.dart';
import 'tabs/web_tab.dart';
import 'tabs/mobile_tab.dart';

import '../widgets/appbar.dart';

class PortofolioScreen extends StatelessWidget {
  const PortofolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Web"),
              Tab(text: "Mobile"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllTab(),
            WebTab(),
            MobileTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF2E3A59),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addPortfolio);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}