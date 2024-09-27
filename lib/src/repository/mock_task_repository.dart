import 'package:stasks/src/DTO/task_dto.dart';
import 'package:stasks/src/repository/task_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import '../entity/task.dart';

class MockTaskRepository implements TaskRepository{
  late int _nextId;

  MockTaskRepository(){
    _nextId = tasks.length;
  }

  List<Task> tasks = [
    Task(
        id: 0,
        date: DateTime.now(),
        name: 'Задача 1',
        description: 'Описание бла бла',
        isDone: false
    ),
    Task(
        id: 1,
        date: DateTime.now(),
        name: 'Задача 2',
        description: 'Описание бла бла',
        isDone: false
    ),
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
        id: tasks.length,
        date: newTaskDTO.date,
        name: newTaskDTO.name,
        description: newTaskDTO.description,
        isDone: false
    );
    tasks.add(newTask);
  }

  @override
  Future<void> deleteTaskById(int id) async {
    tasks.removeWhere((element) => element.id == id);
  }
}