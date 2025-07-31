import 'package:flutter/material.dart';
import 'package:triply/features/home/all_destinations.dart';
import 'widgets/bottom_nav.dart';
import '../trips/screens/create_trip_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool get _hasTrips => false; 

void onAddTrip(BuildContext context) {
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

  final List<Widget> _allPages = allPages;  
  // = [
  //   DashboardPage(),
  //   TripPage(),
  //   SizedBox.shrink(),
  //   ChallengesPage(),
  //   TodoPage(),
  //   ProfilePage(),
  // ];

void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

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
