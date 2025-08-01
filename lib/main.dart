import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:triply/features/challenges/models/challenge_model.dart';
import 'package:triply/features/todo/models/todo_model.dart';
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

Future<Box<T>> openHiveBox<T>(String boxName) async {
  return await Hive.openBox<T>(boxName);
}

void registerAdapter(TypeAdapter adapter) {
  Hive.registerAdapter(adapter);
}

final hiveAdapters = <String, (TypeAdapter, Type)>{
  'challenges': (ChallengeAdapter(), Challenge),
  'todo': (TodoAdapter(), Todo),
  'trip': (TripAdapter(), Trip),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required before async in main
  await Hive.initFlutter();

  // registro tutte le box ("info da memorizzare")
  //hiveAdapters.forEach((key, value) => registerAdapter(value.$1));
  // registerAdapter(ChallengeAdapter());
  // registerAdapter(TodoAdapter());
  // registerAdapter(TripAdapter());
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(ChallengeAdapter());
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Challenge>('challengesBox');
  await Hive.openBox<Todo>('todosBox');
  await Hive.openBox<Trip>('tripsBox');
  // await openHiveBox<Trip>('tripsBox');
  // await openHiveBox<Challenge>('challengesBox');
  // await openHiveBox<Todo>('todosBox');
  runApp(const ProviderScope(child: TriplyApp()));
}
