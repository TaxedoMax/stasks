import 'package:get_it/get_it.dart';
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
}