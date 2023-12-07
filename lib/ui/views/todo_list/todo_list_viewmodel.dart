import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/todo.dart';

class TodoListViewModel extends BaseViewModel {
  List<Todo> todos = [];

  TodoListViewModel() {
    _loadTodos();
  }

  void addTodo(String title) {
    todos.add(Todo(title: title));
    _saveTodos();
    notifyListeners();
  }

  void toggleTodo(int index) {
    todos[index].isCompleted = !todos[index].isCompleted;
    _saveTodos();
    notifyListeners();
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
    _saveTodos();
    notifyListeners();
  }

  Future<void> _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList('todos');
    if (todoList != null) {
      todos = todoList.map((e) => Todo.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = todos.map((e) => e.toJson()).toList();
    prefs.setStringList('todos', todoList);
  }
}
