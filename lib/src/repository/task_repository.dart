import 'package:stasks/src/DTO/task_dto.dart';

import '../entity/task.dart';

abstract class TaskRepository{
  List<Task> getTasksByDay(DateTime day);
  List<Task> getAll();
  Future<void> updateTask(Task newTask);
  Future<void> createTask(TaskDTO newTask);
  Future<void> deleteTaskById(int id);
}