import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:triply/abstraction/base_entity.dart';

abstract class HiveBackedEntityNotifier<T extends BaseEntity>
    extends StateNotifier<List<T>> {
  final String hiveBoxKey;

  HiveBackedEntityNotifier(this.hiveBoxKey) : super([]) {
    _loadFromHive();
  }

  Future<void> _loadFromHive() async {
    final box = await Hive.openBox<T>(hiveBoxKey);
    state = box.values.toList();
  }

  Future<void> _persistToHive() async {
    log("hive box: {$hiveBoxKey} state: {$state}");
    final box = Hive.box<T>(hiveBoxKey);
    await box.clear(); // replace all

    await box.addAll(state);
  }

  void addItem(T item) {
    state = [...state, item];
    log("state {$state} item: {$item}");
    _persistToHive();
  }


  void removeItemById(String id) {
    state = state.where((item) => item.id != id).toList();
    _persistToHive();
  }

  void updateItemById(String id, T Function(T) updateFn) {
    state = [
      for (final item in state)
        if (item.id == id) updateFn(item) else item,
    ];
    _persistToHive();
  }

  void clearAll() {
    state = [];
    _persistToHive();
  }
}
