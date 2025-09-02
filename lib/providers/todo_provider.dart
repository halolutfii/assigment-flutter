import 'package:flutter/foundation.dart';
import '../models/todo_model.dart';
import '../services/todo_services.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  String? _errorMessage;
  bool _isLoading = false; // ✅ Tambah ini

  List<Todo> get todos => _todos;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading; // ✅ Getter

  // constructor langsung fetch data
  TodoProvider() {
    fetchTodos();
  }

  // get all data from API
  Future<void> fetchTodos() async {
    _isLoading = true;      // ✅ mulai loading
    _errorMessage = null;
    notifyListeners();

    try {
      _todos = await TodoService.fetchTodos();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;     // ✅ selesai loading
    notifyListeners();
  }

  // Add todo
  Future<void> addTodo(Todo todo) async {
    _isLoading = true;      // ✅ mulai loading
    notifyListeners();

    try {
      await TodoService.addTodo(todo);
      await fetchTodos();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;     // ✅ selesai loading
    notifyListeners();
  }

  // Update todo
  Future<void> updateTodo(Todo todo) async {
    _isLoading = true;
    notifyListeners();

    try {
      await TodoService.updateTodo(todo);
      await fetchTodos();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Delete todo
  Future<void> deleteTodo(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await TodoService.removeTodo(id);
      await fetchTodos();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ Toggle completed
  Future<void> toggleTodo(String id) async {
    _isLoading = true;
    notifyListeners();

    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = _todos[index];
      final updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        completed: !todo.completed,
      );

      try {
        await TodoService.updateTodo(updatedTodo);
        await fetchTodos();
      } catch (e) {
        _errorMessage = e.toString();
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}