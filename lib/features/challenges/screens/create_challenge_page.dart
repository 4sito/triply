import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/features/challenges/controllers/challenge_controller.dart';
import 'package:triply/features/trips/controllers/trip_controller.dart';

class CreateChallengePage extends ConsumerStatefulWidget {
  final int? challengeIndex;

  const CreateChallengePage({Key? key, this.challengeIndex}) : super(key: key);

  @override
  ConsumerState<CreateChallengePage> createState() =>
      _CreateChallengePageState();
}

class _CreateChallengePageState extends ConsumerState<CreateChallengePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _elementsController = TextEditingController();

  String? _selectedTripId;

  @override
  void initState() {
    super.initState();

    final trips = ref.read(tripListProvider);
    if (trips.isNotEmpty) {
      _selectedTripId = trips.first.id; // default selection
    }

    if (widget.challengeIndex != null) {
      final challenge = ref.read(challengeListProvider)[widget.challengeIndex!];
      _nameController.text = challenge.name;
      _elementsController.text = challenge.elements.join(', ');
      _selectedTripId = challenge.tripId;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _elementsController.dispose();
    super.dispose();
  }

  void _saveChallenge() {
    log("init save challenge");
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final elements = _elementsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      if (_selectedTripId == null) {
        // optionally handle no trip selected
        return;
      }

      final notifier = ref.read(challengeListProvider.notifier);
      final tripsNotifier = ref.read(tripListProvider.notifier);

      if (widget.challengeIndex == null) {
        log("widget challenge index == null");
        var newChallengeId = notifier.addChallenge(
          name,
          _selectedTripId!,
          elements,
        );
        log("save challenge - new challenge id {$newChallengeId}");
        log("save challenge - trip id {$_selectedTripId}");
        tripsNotifier.addChallengeToTrip(_selectedTripId!, newChallengeId);
        log("added challenge to trip!");
      } else {
        log("widget challeng index != null");
        final challenge = ref.read(
          challengeListProvider,
        )[widget.challengeIndex!];
        notifier.updateChallenge(challenge.id, name, elements);
      }

      log("fine? ");

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final trips = ref.watch(tripListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.challengeIndex == null ? 'Create Challenge' : 'Edit Challenge',
        ),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveChallenge),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedTripId,
                decoration: const InputDecoration(labelText: 'Select Trip'),
                items: trips.asMap().entries.map((entry) {
                  final index = entry.key;
                  final trip = entry.value;
                  final isLast = index == trips.length - 1;
                  final shouldDisable = widget.challengeIndex != null && isLast;

                  return DropdownMenuItem<String>(
                    value: trip.id,
                    enabled: !shouldDisable, // this still allows selection
                    child: shouldDisable
                        ? Opacity(
                            opacity: 0.4,
                            child: Text('${trip.name} (locked)'),
                          )
                        : Text(trip.name),
                  );
                }).toList(),
                onChanged: (val) {
                  final selectedTrip = trips.firstWhere((t) => t.id == val);
                  final index = trips.indexOf(selectedTrip);
                  final isLast = index == trips.length - 1;

                  if (widget.challengeIndex != null && isLast) return;

                  setState(() {
                    _selectedTripId = val;
                  });
                },
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please select a trip'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Challenge Name'),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Please enter a challenge name'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _elementsController,
                decoration: const InputDecoration(
                  labelText: 'Elements (comma separated)',
                  hintText: 'e.g. Task 1, Task 2, Task 3',
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Please enter at least one element'
                    : null,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
