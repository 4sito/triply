import 'package:hive/hive.dart';
import 'package:triply/abstraction/base_entity.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 0)
class Trip implements BaseEntity {
  @HiveField(0)
  @override
  final String id;
  @HiveField(1)
  @override
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String destination;
  @HiveField(4)
  final DateTime startDate;
  @HiveField(5)
  final DateTime endDate;
  @HiveField(6)
  final List<String> challengeIds;

  Trip({
    required this.id,
    required this.name,
    required this.destination,
    required this.startDate,
    required this.endDate,
    this.challengeIds = const [],
  });

  Trip copyWith({
    String? id,
    String? name,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? challengeIds,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      challengeIds: challengeIds ?? this.challengeIds,
    );
  }
}
