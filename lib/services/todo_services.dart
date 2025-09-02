import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoService {
  static const String baseUrl = 'https://crudcrud.com/api/d2d7bab62bf546759a158b369dacf4f0/todos';

  // Fetch todos
  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }

  // Add todo
  static Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to add todo");
    }
  }

  // Update todo
  static Future<void> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${todo.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": todo.title,
        "completed": todo.completed,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update todo");
    }
  }

  // Delete todo
  static Future<void> removeTodo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete todo");
    }
  }
}