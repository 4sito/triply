import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/trip_model.dart';

final tripListProvider = StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  return TripListNotifier();
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  TripListNotifier() : super([]);

  void addTrip(String name, String destination, DateTime start, DateTime end) {
    final newTrip = Trip(
      id: const Uuid().v4(),
      name: name,
      destination: destination,
      startDate: start,
      endDate: end,
    );
    state = [...state, newTrip];
  }

  void updateTrip(int index, String name, String destination, DateTime start, DateTime end) {
  state = [
    for (int i = 0; i < state.length; i++)
      if (i == index)
        state[i].copyWith(
          name: name,
          destination: destination,
          startDate: start,
          endDate: end,
        )
      else
        state[i]
  ];
}

  void removeTrip(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void clearAll() {
    state = [];
  }
}

