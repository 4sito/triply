// lib/features/todos/screens/create_todo_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/features/shared/add_list_tile.dart';

import '../controllers/todo_controller.dart';

class CreateTodoPage extends ConsumerStatefulWidget {
  final int? todoIndex; // null = create, otherwise edit

  const CreateTodoPage({super.key, this.todoIndex});

  @override
  ConsumerState<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends ConsumerState<CreateTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _elementControllers = <TextEditingController>[];
  final _focusNodes = <FocusNode>[];

  @override
  void initState() {
    super.initState();
    if (widget.todoIndex != null) {
      final todo = ref.read(todoListProvider)[widget.todoIndex!];
      _nameController.text = todo.name;
      for (var e in todo.elements) {
        _elementControllers.add(TextEditingController(text: e));
        _focusNodes.add(FocusNode());
      }
    }

    // Ensure at least one field
    if (_elementControllers.isEmpty) {
      _elementControllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (var c in _elementControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addField() {
    setState(() {
      _elementControllers.add(TextEditingController());
      final node = FocusNode();
      _focusNodes.add(node);

      // Delay focus request to next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(node);
      });
    });
  }

  void _removeField(int idx) {
    setState(() {
      _elementControllers.removeAt(idx).dispose();
      _focusNodes.removeAt(idx).dispose();
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final elements = _elementControllers
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final notifier = ref.read(todoListProvider.notifier);
    if (widget.todoIndex == null) {
      notifier.addTodo(name, elements);
    } else {
      final todo = ref.read(todoListProvider)[widget.todoIndex!];
      notifier.updateTodo(todo.id, name, elements);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todoIndex != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit To-Do List' : 'Create To-Do List'),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: _save)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 1) Title
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'List Name'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter a name' : null,
              ),
              const SizedBox(height: 16),

              // 2) Dynamic item fields
              Expanded(
                child: ListView.builder(
                  itemCount: _elementControllers.length,
                  itemBuilder: (context, i) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // bullet or handle
                        const Icon(Icons.drag_handle),

                        // text field
                        Expanded(
                          child: TextFormField(
                            controller: _elementControllers[i],
                            focusNode: _focusNodes[i], // 🔥 Important!
                            decoration: InputDecoration(
                              labelText: 'Item ${i + 1}',
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Enter an item or remove it'
                                : null,
                            onFieldSubmitted: (_) {
                              final isLast =
                                  i == _elementControllers.length - 1;
                              if (isLast) {
                                _addField(); // Will auto-focus next field
                              }
                            },
                          ),
                        ),

                        // remove button (if more than one)
                        if (_elementControllers.length > 1)
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () => _removeField(i),
                          ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),
              // 3) “Add another item” button
              AddListTile(title: 'Add another item', onTap: _addField),
            ],
          ),
        ),
      ),
    );
  }
}
