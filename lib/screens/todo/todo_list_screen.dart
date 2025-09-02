import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/todo_provider.dart';
import './add_todo_screen.dart';
import './edit_todo_screen.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().todos;

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Consumer<TodoProvider>(
  builder: (context, provider, _) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    if (provider.todos.isEmpty) {
      return const Center(child: Text('No todos available'));
    }

    return ListView.builder(
      itemCount: provider.todos.length,
      itemBuilder: (context, index) {
        final todo = provider.todos[index];

        return Dismissible(
          key: Key(todo.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (_) async {
            return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Delete Todo'),
                content:
                    const Text('Are you sure you want to delete this task?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) async {
            await context.read<TodoProvider>().deleteTodo(todo.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${todo.title} deleted')),
            );
          },
          child: ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration:
                    todo.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: todo.completed,
              onChanged: (_) =>
                  context.read<TodoProvider>().toggleTodo(todo.id),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditTodoScreen(todo: todo),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  },
),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddTodoScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}