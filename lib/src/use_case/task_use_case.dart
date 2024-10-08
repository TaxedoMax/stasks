import 'package:get_it/get_it.dart';
import 'package:stasks/src/extentions.dart';
import 'package:stasks/src/repository/task_repository.dart';

import '../DTO/task_dto.dart';
import '../entity/task.dart';

class TaskUseCase{
  final TaskRepository _taskRepository = GetIt.I.get<TaskRepository>();

  Future<void> migrateData() async {
    List<Task> tasks = _taskRepository.getAll();
    for(var task in tasks){
      if(task.position == -1){
        List<Task> thisDay = _taskRepository.getTasksByDay(task.date);
        await _migrateDay(thisDay);
      }
    }
  }

  Future<void> _migrateDay(List<Task> tasks) async {
    int unfinishedIndex = 0;
    int finishedIndex = getUnfinishedCount(tasks.first.date);

    for(var task in tasks){
      if(task.isDone){
        await _taskRepository.updateTask(task.copyWith(position: finishedIndex));
        finishedIndex++;
      } else{
        await _taskRepository.updateTask(task.copyWith(position: unfinishedIndex));
        unfinishedIndex++;
      }
    }
  }

  Future<void> updateTaskContent(Task newTask) async {
    Task oldTask = _taskRepository.getTaskById(newTask.id);
    newTask = newTask.copyWith(position: oldTask.position);

    if(oldTask.isDone != newTask.isDone){
      await _taskRepository.updateTask(newTask);
      int position = _taskRepository.getTasksByDay(oldTask.date).length;
      newTask = newTask.copyWith(position: position);
      await updateTaskPosition(newTask.copyWith(position: position));
    }
    else if(oldTask.date.compareWithoutTime(newTask.date) != 0){
      var list = getTasksByDay(newTask.date);
      for(var task in list){
        if(task.isDone){
          await _taskRepository
              .updateTask(task.copyWith(position: task.position + 1));
        }
      }
      int position = _taskRepository.getUnfinishedCountByDay(newTask.date);
      await _taskRepository.updateTask(newTask.copyWith(position: position));
    }
    else{
      await _taskRepository.updateTask(newTask);
    }
  }

  List<Task> getTasksByDay(DateTime day) {
    var list = _taskRepository.getTasksByDay(day);
    return list;
  }

  Future<void> createTask(TaskDTO newTask) async {
    await _taskRepository.createTask(newTask);
  }

  Future<void> deleteTaskById(int id) async {
    Task oldTask = _taskRepository.getTaskById(id);
    int position = _taskRepository.getTasksByDay(oldTask.date).length;
    await _taskRepository.updateTask(oldTask.copyWith(position: position));
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

  int getUnfinishedCount(DateTime day){
    return _taskRepository.getUnfinishedCountByDay(day);
  }

  int getFinishedCount(DateTime day){
    return _taskRepository.getFinishedCountByDay(day);
  }

  Future<void> updateTaskPosition(Task newTask) async {
    List<Task> list = _taskRepository.getTasksByDay(newTask.date);
    List<Task> updatedList = [];
    Task oldTask = list.firstWhere((element) => element.id == newTask.id);
    int unfinishedCount = getUnfinishedCount(newTask.date);
    int newPosition = newTask.position;
    int oldPosition = oldTask.position;

    if(oldPosition < newPosition){
      newPosition--;
    }

    if(newTask.isDone){
      newPosition = newPosition >= unfinishedCount ? newPosition : unfinishedCount;
    }
    else{
      newPosition = newPosition < unfinishedCount ? newPosition : unfinishedCount - 1;
    }

    updatedList.add(newTask.copyWith(position: newPosition));
    if(newPosition > oldPosition){
      for(Task task in list){
        if(task.id != newTask.id && task.position > oldPosition && task.position <= newPosition){
          updatedList.add(task.copyWith(position: task.position - 1));
        }
      }
    } else{
      for(Task task in list){
        if(task.id != newTask.id && task.position >= newPosition && task.position < oldPosition){
          updatedList.add(task.copyWith(position: task.position + 1));
        }
      }
    }

    for(Task task in updatedList){
      await _taskRepository.updateTask(task);
    }
  }
}