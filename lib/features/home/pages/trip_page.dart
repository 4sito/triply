// lib/features/trips/screens/trip_page.dart

import 'package:flutter/material.dart';
import 'package:triply/abstraction/base_list.dart';
import 'package:triply/features/trips/controllers/trip_controller.dart';
import 'package:triply/features/trips/models/trip_model.dart';
import 'package:triply/features/trips/screens/create_trip_page.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EntityListPage<Trip>(
      listProvider: tripListProvider,
      createPage: () => const CreateTripPage(),
      pageTitle: 'Your Trips',
      icon: Icons.airplane_ticket,
      iconOutlined: Icons.airplane_ticket_outlined,
      emptyMessage: 'No trips added yet.',
      addButtonTitle: 'Add a new trip',
      itemTileBuilder: (ctx, ref, trip, index) {
        final theme = Theme.of(ctx);

        return ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: theme.colorScheme.outline, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: theme.colorScheme.inversePrimary,
          title: Text(trip.name),
          subtitle: Text(
            '${trip.destination} • ${trip.startDate.toString().split(" ")[0]} → ${trip.endDate.toString().split(" ")[0]}\nNumber of challenges ${trip.challengeIds.length}',
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: theme.colorScheme.error),
            onPressed: () {
              ref.read(tripListProvider.notifier).removeItemById(trip.id);
            },
          ),
          onTap: () {
            Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (_) => CreateTripPage(tripIndex: index),
              ),
            );
          },
        );
      },
    );
  }
}
