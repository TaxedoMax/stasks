import 'package:flutter/cupertino.dart';

@immutable
class Task{
  final int id;
  final DateTime date;
  final String name;
  final String description;
  final bool isDone;

  const Task(this.id, this.date, this.name, this.description, this.isDone);

  Task copyWith({
    int? id,
    DateTime? date,
    String? name,
    String? description,
    bool? isDone
  })=> Task(
      id ?? this.id,
      date ?? this.date,
      name ?? this.name,
      description ?? this.description,
      isDone ?? this.isDone
    );
}