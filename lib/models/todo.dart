import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });

  factory Todo.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return Todo(
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() {
    return jsonEncode({
      'title': title,
      'isCompleted': isCompleted,
    });
  }
}
