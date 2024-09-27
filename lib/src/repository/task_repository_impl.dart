import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:stasks/src/DTO/TaskDTO.dart';
import 'package:stasks/src/entity/task.dart';
import 'package:stasks/src/repository/task_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskRepositoryImpl extends TaskRepository{
  final _taskBox = Hive.box<Task>('box_for_task');

  @override
  Future<void> createTask(TaskDTO newTask) async {
    Task tmp = Task(-1, newTask.date, newTask.name, newTask.description, false);
    int id = await _taskBox.add(tmp);
    await _taskBox.put(id, tmp.copyWith(id: id));
  }

  @override
  Future<void> deleteTaskById(int id) async {
    await _taskBox.delete(id);
  }

  @override
  List<Task> getTasksByDay(DateTime day) {
    List<Task> result = [];

    for(int i = 0; i < _taskBox.length; i++){
      Task current = _taskBox.getAt(i)!;

      if(isSameDay(current.date, day)){
        result.add(current);
      }
    }

    return result;
  }

  @override
  Future<void> updateTask(Task newTask) async {
    await _taskBox.put(newTask.id, newTask);
  }

}