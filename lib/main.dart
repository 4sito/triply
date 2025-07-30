import 'package:flutter/material.dart';
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



void main() {
  runApp(
    const ProviderScope(
      child: TriplyApp(),
    ),
  );
}

