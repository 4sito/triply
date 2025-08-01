import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/abstraction/hive_backend_notifier.dart';
import 'package:uuid/uuid.dart';
import '../models/trip_model.dart';

final tripListProvider = StateNotifierProvider<TripListNotifier, List<Trip>>((
  ref,
) {
  return TripListNotifier();
});

class TripListNotifier extends HiveBackedEntityNotifier<Trip> {
  TripListNotifier() : super('tripsBox');

  void addTrip(String name, String destination, DateTime start, DateTime end) {
    final newTrip = Trip(
      id: const Uuid().v4(),
      name: name,
      destination: destination,
      startDate: start,
      endDate: end,
    );
    addItem(newTrip);
  }

  void addChallengeToTrip(String tripId, String challengeId) {
    log('Updating trip: $tripId with challengeId: $challengeId');
    updateItemById(tripId, (trip) {
      final updatedChallengeIds = [...trip.challengeIds, challengeId];
      return trip.copyWith(challengeIds: updatedChallengeIds);
    });
  }

  void removeChallengeFromTrip(String tripId, String challengeId) {
    updateItemById(tripId, (trip) {
      final updatedChallengeIds = trip.challengeIds
          .where((id) => id != challengeId)
          .toList();
      return trip.copyWith(challengeIds: updatedChallengeIds);
    });
  }

  void updateTrip(
    String id,
    String name,
    String destination,
    DateTime start,
    DateTime end,
  ) {
    log("updating trip $id");
    updateItemById(
      id,
      (trip) => trip.copyWith(
        name: name,
        destination: destination,
        startDate: start,
        endDate: end,
      ),
    );
  }
}
