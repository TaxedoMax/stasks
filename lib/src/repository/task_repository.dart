import 'package:stasks/src/DTO/TaskDTO.dart';

import '../entity/task.dart';

abstract class TaskRepository{
  List<Task> getTasksByDay(DateTime day);
  Future<void> updateTask(Task newTask);
  Future<void> createTask(TaskDTO newTask);
  Future<void> deleteTaskById(int id);
}