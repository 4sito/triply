import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/abstraction/hive_backend_notifier.dart';
import 'package:uuid/uuid.dart';
import '../models/challenge_model.dart';

final challengeListProvider = StateNotifierProvider<ChallengeListNotifier, List<Challenge>>((ref) {
  return ChallengeListNotifier();
});

class ChallengeListNotifier extends HiveBackedEntityNotifier<Challenge> {
  ChallengeListNotifier() : super('challengesBox');

  String addChallenge(String name, String tripId, List<String> elements) {
    final newChallenge = Challenge(
      id: const Uuid().v4(),
      name: name,
      tripId: tripId,
      elements: elements,
    );
    addItem(newChallenge);
    log("new challenge id : {$newChallenge.id}");
    return newChallenge.id;
  }

  void updateChallenge(String id, String name, List<String> elements) {
    updateItemById(id, (challenge) => challenge.copyWith(
      name: name,
      elements: elements,
    ));
  }
}
