import 'package:flutter/material.dart';

class AddOptionsModal extends StatelessWidget {
  final bool hasTrips;
  final VoidCallback onAddTrip;
  final VoidCallback onAddChallenge;

  const AddOptionsModal({
    super.key,
    required this.hasTrips,
    required this.onAddTrip,
    required this.onAddChallenge,
  });

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return SizedBox(
      width: 300,
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.flight_takeoff),
            title: const Text('Add New Trip'),
            onTap: () {
              Navigator.pop(context);
              onAddTrip();
            },
          ),
          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Add Challenge'),
            subtitle: !hasTrips ? const Text('You need a trip first') : null,
            enabled: hasTrips,
            onTap: () {
              if (hasTrips) {
                Navigator.pop(context);
                onAddChallenge();
              }
            },
          ),
        ],
      ),
    );
  }
}
