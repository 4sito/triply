import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../trips/controllers/trip_controller.dart';
import 'base_page.dart';

class TripPage extends ConsumerWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripListProvider);
    // print("trips: $trips, trips is empty? ${trips.isEmpty}");

    var pageBody;

  if (trips.isEmpty) {
    pageBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Center(child: Text('No trips added yet.')),
        SizedBox(height: 16),
        Text(
          "You can create, edit and complete challenges here.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  } else {
    pageBody = ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final trip = trips[index];
        return ListTile(
          tileColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(trip.name),
          subtitle: Text(
            '${trip.destination} • ${trip.startDate.toString().split(" ")[0]} → ${trip.endDate.toString().split(" ")[0]}',
          ),
        );
      },
    );
  }
    return BasePage(
      title: 'Your Trips',
      child: pageBody,
    );
  }
}
