import 'package:flutter/material.dart';
import 'package:triply/features/home/all_destinations.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

// final allDestinations = allDestinations;

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