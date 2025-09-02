import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/todo_model.dart';
import '../../providers/todo_provider.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Todo title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = _controller.text;
                if (title.isNotEmpty) {
                  final newTodo = Todo(
                    id: DateTime.now().toString(), // generate sementara
                    title: title,
                    completed: false,
                  );

                  try {
                    await context.read<TodoProvider>().addTodo(newTodo);
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add todo: $e')),
                      );
                    }
                  }
                }
              },
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}