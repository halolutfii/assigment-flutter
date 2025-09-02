import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/todo_model.dart';
import '../../providers/todo_provider.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  const EditTodoScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: todo.title);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Edit title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newTitle = controller.text;
                if (newTitle.isNotEmpty) {
                  final updatedTodo = Todo(
                    id: todo.id,
                    title: newTitle,
                    completed: todo.completed,
                  );

                  await context.read<TodoProvider>().updateTodo(updatedTodo);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}