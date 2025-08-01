// lib/features/todo/screens/todos_page.dart

import 'package:flutter/material.dart';
import 'package:triply/abstraction/base_list.dart';
import 'package:triply/features/todo/controllers/todo_controller.dart';
import 'package:triply/features/todo/models/todo_model.dart';
import 'package:triply/features/todo/screens/create_todo_page.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EntityListPage<Todo>(
      listProvider: todoListProvider,
      createPage: () => const CreateTodoPage(),
      pageTitle: 'Your Todos',
      icon: Icons.check_circle,
      iconOutlined: Icons.check_circle_outline,
      emptyMessage: 'No todos added yet.',
      addButtonTitle: 'Add a new todo',
      itemTileBuilder: (ctx, ref, todo, index) {
        final theme = Theme.of(ctx);

        return ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: theme.colorScheme.outline, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: theme.colorScheme.inversePrimary,
          title: Text(todo.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: todo.elements.map((e) => Text("• $e")).toList(),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: theme.colorScheme.error),
            onPressed: () {
              ref.read(todoListProvider.notifier).removeItemById(todo.id);
            },
          ),
          onTap: () {
            Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (_) => CreateTodoPage(todoIndex: index),
              ),
            );
          },
        );
      },
    );
  }
}
