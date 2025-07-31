import 'package:hive/hive.dart';
import 'package:triply/abstraction/base_entity.dart';

part 'challenge_model.g.dart';

@HiveType(typeId: 1)
class Challenge implements BaseEntity {
  @HiveField(0)
  @override
  final String id;
  @HiveField(1)
  @override
  final String name;
  @HiveField(2)
  final String tripId;
  @HiveField(3)
  final List<String> elements;

  Challenge({required this.id, required this.name, required this.tripId, required this.elements});

  Challenge copyWith({String? id, String? name, String? tripId, List<String>? elements}) {
    return Challenge(
      id: id ?? this.id,
      name: name ?? this.name,
      tripId: tripId ?? this.tripId,
      elements: elements ?? this.elements,
    );
  }
}
