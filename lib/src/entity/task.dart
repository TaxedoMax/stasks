import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@immutable
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

  @HiveField(5)
  final int? parentId;

  @HiveField(6, defaultValue: -1)
  final int position;

  int compareTo(Task task){
    int result;
    if(isDone == task.isDone){
      result = 0;
    } else if(isDone){
      result = 1;
    } else{
      result = 0;
    }

    return result;
  }

  const Task({
    required this.id,
    required this.date,
    required this.name,
    required this.description,
    required this.isDone,
    required this.position,
    this.parentId,
  });

  Task copyWith({
    int? id,
    DateTime? date,
    String? name,
    String? description,
    bool? isDone,
    int? position,
    int? parentId
  })=> Task(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      position: position ?? this.position,
      parentId: parentId
    );
}