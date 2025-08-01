// lib/features/todos/controllers/todo_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:triply/abstraction/hive_backend_notifier.dart';
import '../models/todo_model.dart';

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends HiveBackedEntityNotifier<Todo> {
  TodoListNotifier() : super('todosBox');

  String addTodo(String name, List<String> elements) {
    final newTodo = Todo(
      id: const Uuid().v4(),
      name: name,
      elements: elements,
    );
    addItem(newTodo);
    return newTodo.id;
  }

  void updateTodo(String id, String name, List<String> elements) {
    updateItemById(id, (t) => t.copyWith(name: name, elements: elements));
  }

  void removeTodo(String id) {
    removeItemById(id);
  }
}
