// lib/features/challenges/screens/challenges_page.dart

import 'package:flutter/material.dart';
import 'package:triply/abstraction/base_list.dart';
import 'package:triply/features/challenges/controllers/challenge_controller.dart';
import 'package:triply/features/challenges/models/challenge_model.dart';
import 'package:triply/features/challenges/screens/create_challenge_page.dart';
import '../../trips/controllers/trip_controller.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EntityListPage<Challenge>(
      listProvider: challengeListProvider,
      createPage: () => const CreateChallengePage(),
      pageTitle: 'Your Challenges',
      icon: Icons.flag,
      iconOutlined: Icons.outlined_flag,
      emptyMessage: 'No challenges added yet.',
      addButtonTitle: 'Add a new challenge',
      itemTileBuilder: (ctx, ref, challenge, index) {
        final trips = ref.watch(tripListProvider);
        final trip = trips.firstWhere((t) => t.id == challenge.tripId);
        final theme = Theme.of(ctx);
        return ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: theme.colorScheme.outline, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: theme.colorScheme.inversePrimary,
          title: Text(challenge.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trip: ${trip.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              ...challenge.elements.map((e) => Text(e)),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: theme.colorScheme.error),
            onPressed: () {
              ref
                  .read(challengeListProvider.notifier)
                  .removeItemById(challenge.id);
              ref
                  .read(tripListProvider.notifier)
                  .removeChallengeFromTrip(challenge.tripId, challenge.id);
            },
          ),
          onTap: () {
            Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (_) => CreateChallengePage(challengeIndex: index),
              ),
            );
          },
        );
      },
    );
  }
}
