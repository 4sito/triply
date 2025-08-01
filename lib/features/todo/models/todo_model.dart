import 'package:hive/hive.dart';
import 'package:triply/abstraction/base_entity.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 2)

class Todo implements BaseEntity {
    @HiveField(0)
  @override
  final String id;
    @HiveField(1)
  @override
  final String name;
    @HiveField(2)
  final List<String> elements;

  Todo({
    required this.id,
    required this.name,
    required this.elements,
  });

  Todo copyWith({
    String? id,
    String? name,
    List<String>? elements,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      elements: elements ?? this.elements,
    );
  }
}
