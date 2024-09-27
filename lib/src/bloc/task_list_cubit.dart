import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/DTO/TaskDTO.dart';

import '../entity/task.dart';
import '../repository/task_repository.dart';

class TaskListCubit extends Cubit<TaskListState>{

  final TaskRepository repository;

  TaskListCubit(this.repository)
      :super(TaskListState(selectedDay: DateTime.now(), list: []));

  loadByDay(DateTime day){
    List<Task> list = repository.getTasksByDay(day);
    emit(TaskListState(selectedDay: day, list: list));
  }

  updateTask(Task newTask) async {
    await repository.updateTask(newTask);
    loadByDay(state.selectedDay);
  }

  createTask(TaskDTO newTask) async {
    await repository.createTask(newTask);
    loadByDay(state.selectedDay);
  }

  deleteTask(int id) async {
    await repository.deleteTaskById(id);
    loadByDay(state.selectedDay);
  }
}

class TaskListState{
  final DateTime selectedDay;
  final List<Task> list;
  TaskListState({required this.selectedDay, required this.list});
}