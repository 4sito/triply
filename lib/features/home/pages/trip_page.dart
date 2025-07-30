import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../trips/controllers/trip_controller.dart';
import 'base_page.dart';
import '../../home/home_screen.dart';
import '../../trips/screens/create_trip_page.dart';

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
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.flight_takeoff, size: 64, color: Colors.grey),
                onPressed: () => {onAddTrip(context)},
              ),
              SizedBox(height: 16),
              Text('No trips added yet.', style: TextStyle(fontSize: 18)),
            ],
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
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(trip.name),
            subtitle: Text(
              '${trip.destination} • ${trip.startDate.toString().split(" ")[0]} → ${trip.endDate.toString().split(" ")[0]}',
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
    return BasePage(title: 'Your Trips', child: pageBody);
  }
}
