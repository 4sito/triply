import 'package:flutter/material.dart';
import 'package:triply/features/home/widgets/destination.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNav({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

final allDestinations = [
  Destination(0, "Home", Icons.home, Icons.home_outlined),
  Destination(1, "Trips", Icons.airplane_ticket, Icons.airplane_ticket_outlined),
  Destination(2, "Add", Icons.add, Icons.add_circle_outline),
  Destination(3, "Challenges", Icons.emoji_events, Icons.emoji_events_outlined),
  Destination(4, "Profile", Icons.person, Icons.person_outline),
];

@override
Widget build(BuildContext context) {
  var theme = Theme.of(context);

  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    // backgroundColor: Colors.black,
    selectedItemColor: theme.colorScheme.primary,
    unselectedItemColor: Colors.grey,
    items: allDestinations.map<BottomNavigationBarItem>((destination) {
      return BottomNavigationBarItem(
        icon: Icon(
          currentIndex == destination.index
              ? destination.icon
              : destination.secondIcon,
          color: theme.colorScheme.primary,
        ),
        backgroundColor: theme.colorScheme.primaryContainer,
        label: destination.title,
      );
    }).toList(),
  );
}
}