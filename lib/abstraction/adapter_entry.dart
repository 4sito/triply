import 'package:hive/hive.dart';
import 'package:triply/features/todo/models/todo_model.dart';

typedef AdapterEntry = (String, (TypeAdapter<dynamic>, Type));

// Usage
final entry = (
  'todo',
  (TodoAdapter(), Todo)
);

final name = entry.$1;
final adapter = entry.$2.$1;
final type = entry.$2.$2;
