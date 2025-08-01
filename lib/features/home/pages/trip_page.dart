import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/features/shared/add_list_tile.dart';
import '../../trips/controllers/trip_controller.dart';
import '../../../abstraction/base_page.dart';
import '../../trips/screens/create_trip_page.dart';

class TripPage extends ConsumerWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripListProvider);
    // print("trips: $trips, trips is empty? ${trips.isEmpty}");
    final theme = Theme.of(context);
    var pageBody;

    if (trips.isEmpty) {
      pageBody = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('No trips added yet.', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          AddListTile(
            title: 'Add a new trip',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateTripPage()),
              );
            },
          ),
        ],
      );
    } else {
      pageBody = ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          if (index == trips.length) {
            // Last item: the "Add Trip" tile
            return AddListTile(
              title: 'Add a new trip',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateTripPage()),
                );
              },
            );
          }

          final trip = trips[index];
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
              icon: Icon(Icons.delete, color: theme.colorScheme.inverseSurface),
              onPressed: () {
                // Handle delete logic here
                trips.removeAt(index);
                ref
                    .read(tripListProvider.notifier)
                    .removeItemById(index.toString());
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateTripPage(tripIndex: index),
                ),
              );
            },
          );
        },
      );
    }
    return BasePage(
      title: 'Your Trips',
      icon: Icons.airplane_ticket,
      iconOutlined: Icons.airplane_ticket_outlined,
      child: pageBody,
    );
  }
}
