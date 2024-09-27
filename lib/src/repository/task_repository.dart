import 'package:stasks/src/DTO/TaskDTO.dart';

import '../entity/task.dart';

abstract class TaskRepository{
  List<Task> getTasksByDay(DateTime day);
  void updateTask(Task newTask);
  void createTask(TaskDTO newTask);
  void deleteTaskById(int id);
}