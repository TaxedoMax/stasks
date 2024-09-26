import '../entity/task.dart';

abstract class TaskRepository{
  List<Task> getTasksByDay(DateTime day);
  void updateTask(Task newTask);
}