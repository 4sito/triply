import 'package:triply/abstraction/base_entity.dart';

class Todo implements BaseEntity {
  @override
  final String id;
  @override
  final String name;
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
