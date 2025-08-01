// lib/features/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:triply/features/home/all_destinations.dart';
import 'widgets/bottom_nav.dart';
import '../trips/screens/create_trip_page.dart';
import 'pages/dashboard_page.dart'; // import this explicitly if not already

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void onAddTrip(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const CreateTripPage()),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _allPages;

  @override
  void initState() {
    super.initState();

    _allPages = [
      DashboardPage(onSectionTap: _onNavTap),
      ...allPages.sublist(1), // reuse the rest
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _allPages[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
