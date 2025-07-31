import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/features/shared/add_list_tile.dart';
import 'package:triply/features/trips/controllers/trip_controller.dart';
import '../../challenges/controllers/challenge_controller.dart';
import '../../../abstraction/base_page.dart';
import '../../challenges/screens/create_challenge_page.dart';

class ChallengesPage extends ConsumerWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenges = ref.watch(challengeListProvider);
    final trips = ref.watch(tripListProvider);
    final theme = Theme.of(context);
    Widget pageBody;

    if (challenges.isEmpty) {
      pageBody = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('No challenges added yet.', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          AddListTile(
            title: 'Add a new challenge',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateChallengePage()),
              );
            },
          ),
        ],
      );
    } else {
      pageBody = ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: challenges.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          if (index == challenges.length) {
            return AddListTile(
              title: 'Add a new challenge',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateChallengePage(),
                  ),
                );
              },
            );
          }

          final challenge = challenges[index];
          final trip = trips.firstWhere(
            (t) => t.id == challenge.tripId,
          );

          return ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: theme.colorScheme.outline, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: theme.colorScheme.inversePrimary,
            title: Text(challenge.name), // assuming `title` field
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                    'Trip: ${trip.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ...challenge.elements.map((e) => Text(e)),
              ],
            ), // assuming optional `description`
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                ref
                    .read(challengeListProvider.notifier)
                    .removeItemById(challenge.id);
                ref.read(tripListProvider.notifier).removeChallengeFromTrip(challenge.tripId, challenge.id);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateChallengePage(challengeIndex: index),
                ),
              );
            },
          );
        },
      );
    }

    return BasePage(
      title: 'Your Challenges',
      icon: Icons.flag,
      iconOutlined: Icons.outlined_flag,
      child: pageBody,
    );
  }
}
