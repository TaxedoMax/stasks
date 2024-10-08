import 'package:stasks/src/DTO/task_dto.dart';

import '../entity/task.dart';

abstract class TaskRepository{
  Task getTaskById(int id);
  List<Task> getTasksByDay(DateTime day);
  List<Task> getAll();
  int getUnfinishedCountByDay(DateTime day);
  int getFinishedCountByDay(DateTime day);
  Future<void> updateTask(Task newTask);
  Future<void> createTask(TaskDTO newTask);
  Future<void> deleteTaskById(int id);
}