import 'package:flutter/material.dart';
// import 'package:triply/features/home/pages/base_page.dart';
import 'package:triply/features/home/pages/dashboard_page.dart';
import 'package:triply/features/home/pages/trip_page.dart';
import 'package:triply/features/home/pages/challenges_page.dart';
import 'package:triply/features/home/pages/profile_page.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/add_options_modal.dart';
import '../trips/screens/create_trip_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool get _hasTrips => false; 

void _onAddTrip(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const CreateTripPage()),
  );
}
void _onAddChallenge() {
  debugPrint('Challenge creation flow');
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> allPages = [
    DashboardPage(),
    TripPage(),
    SizedBox.shrink(),
    ChallengesPage(),
    ProfilePage(),
  ];

void _onNavTap(int index) {
  if (index == 2) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (_) => AddOptionsModal(
        hasTrips: _hasTrips,
        onAddTrip: () => _onAddTrip(context),
        onAddChallenge: _onAddChallenge,
      ),
    );
  } else {
    setState(() {
      _currentIndex = index;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allPages[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
