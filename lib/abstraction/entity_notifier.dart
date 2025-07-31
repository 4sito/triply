import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/abstraction/base_entity.dart';

abstract class EntityNotifier<T extends BaseEntity> extends StateNotifier<List<T>> {
  EntityNotifier() : super([]);

  void addItem(T item) {
    state = [...state, item];
  }

  void removeItemById(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateItemById(String id, T Function(T) updateFn) {
    state = [
      for (final item in state)
        if (item.id == id) updateFn(item) else item,
    ];
  }

  void clearAll() {
    state = [];
  }
}
