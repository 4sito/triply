import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/trip_controller.dart';

class CreateTripPage extends ConsumerStatefulWidget {
  final int? tripIndex; // if null → create, else → edit
  const CreateTripPage({this.tripIndex, super.key});

  @override
  ConsumerState<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends ConsumerState<CreateTripPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final destinationController = TextEditingController();
  final dateRangeController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();

    if (widget.tripIndex != null) {
      final trip = ref.read(tripListProvider)[widget.tripIndex!];
      nameController.text = trip.name;
      destinationController.text = trip.destination;
      startDate = trip.startDate;
      endDate = trip.endDate;
      dateRangeController.text =
          '${startDate!.toLocal().toString().split(' ')[0]} → ${endDate!.toLocal().toString().split(' ')[0]}';
    }
  }

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
        dateRangeController.text =
            '${picked.start.toLocal().toString().split(' ')[0]} → ${picked.end.toLocal().toString().split(' ')[0]}';
      });
    }
  }

  void _submit() {
  if (nameController.text.isEmpty ||
      destinationController.text.isEmpty ||
      startDate == null ||
      endDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All fields must be filled')),
    );
    return;
  }

  if (_formKey.currentState!.validate()) {
    final notifier = ref.read(tripListProvider.notifier);

    if (widget.tripIndex != null) {
      notifier.updateTrip(
        widget.tripIndex!,
        nameController.text,
        destinationController.text,
        startDate!,
        endDate!,
      );
    } else {
      notifier.addTrip(
        nameController.text,
        destinationController.text,
        startDate!,
        endDate!,
      );
    }

    Navigator.pop(context);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Details")),
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
              TextFormField(
                readOnly: true,
                controller: dateRangeController,
                decoration: const InputDecoration(
                  labelText: 'Trip Dates',
                  hintText: 'Select date range',
                ),
                onTap: _pickDateRange,
              ),
              // const SizedBox(height: 12),
              // ElevatedButton.icon(
              //   icon: const Icon(Icons.date_range),
              //   label: const Text('Pick Start & End Date'),
              //   onPressed: _pickDateRange,
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Save Trip"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
