import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:triply/features/challenges/models/challenge_model.dart';
import 'package:triply/features/trips/models/trip_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://your-project-id.supabase.co',
    anonKey: 'your-anon-key',
  );


*/


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(ChallengeAdapter());
  await Hive.openBox<Trip>('tripsBox');
  await Hive.openBox<Challenge>('challengesBox');
  runApp(const ProviderScope(child: TriplyApp()));
}
