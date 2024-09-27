import 'package:stasks/src/DTO/TaskDTO.dart';
import 'package:stasks/src/repository/task_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import '../entity/task.dart';

class MockTaskRepository implements TaskRepository{
  List<Task> tasks = [
    Task(0, DateTime.now(), 'Задача 1', 'Описание бла бла', false),
    Task(1, DateTime.now(), 'Задача 2', 'Описание бла бла', false),
  ];

  @override
  List<Task> getTasksByDay(DateTime day){
    List<Task> result = [];

    for(Task task in tasks){
      if(isSameDay(task.date, day)){
        result.add(task);
      }
    }

    return result;
  }

  @override
  Future<void> updateTask(Task newTask) async {
    int index = tasks.indexWhere((task) => task.id == newTask.id);

    if(index == -1) throw Exception('No such task');

    tasks[index] = newTask;
  }

  @override
  Future<void> createTask(TaskDTO newTaskDTO) async {
    Task newTask = Task(
        tasks.length,
        newTaskDTO.date,
        newTaskDTO.name,
        newTaskDTO.description,
        false
    );
    tasks.add(newTask);
  }

  @override
  Future<void> deleteTaskById(int id) async {
    tasks.removeWhere((element) => element.id == id);
  }
}