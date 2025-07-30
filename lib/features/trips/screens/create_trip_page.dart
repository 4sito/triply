import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/trip_controller.dart';

class CreateTripPage extends ConsumerStatefulWidget {
  const CreateTripPage({super.key});

  @override
  ConsumerState<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends ConsumerState<CreateTripPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final destinationController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && startDate != null && endDate != null) {
      ref.read(tripListProvider.notifier).addTrip(
            nameController.text,
            destinationController.text,
            startDate!,
            endDate!,
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Trip")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Trip Name'),
                validator: (v) => v!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                controller: destinationController,
                decoration: const InputDecoration(labelText: 'Destination'),
                validator: (v) => v!.isEmpty ? 'Enter a destination' : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.date_range),
                label: const Text('Pick Start & End Date'),
                onPressed: _pickDateRange,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Create Trip"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
