import 'package:get_it/get_it.dart';
import 'package:stasks/src/extentions.dart';
import 'package:stasks/src/repository/task_repository.dart';

import '../DTO/task_dto.dart';
import '../entity/task.dart';

class TaskUseCase{
  final TaskRepository _taskRepository = GetIt.I.get<TaskRepository>();

  Future<void> updateTask(Task newTask) async {
    await _taskRepository.updateTask(newTask);
  }

  List<Task> getTasksByDay(DateTime day) {
    var list = _taskRepository.getTasksByDay(day);
    return list;
  }

  Future<void> createTask(TaskDTO newTask) async {
    await _taskRepository.createTask(newTask);
  }

  Future<void> deleteTaskById(int id) async {
    await _taskRepository.deleteTaskById(id);
  }

  Future<void> shiftOutdatedTasks(DateTime day) async {
    List<Task> tasks = _taskRepository.getAll();
    List<Task> updatedTasks = [];

    for(Task task in tasks){
      if(task.date.compareWithoutTime(day) == -1 && !task.isDone){
        Task newTask = task.copyWith(date: day);
        updatedTasks.add(newTask);
      }
    }

    for(Task task in updatedTasks){
      await _taskRepository.updateTask(task);
    }
  }
}