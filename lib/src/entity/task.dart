import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

//@immutable
@HiveType(typeId: 0)
class Task{
  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String description;

  @HiveField(4)
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