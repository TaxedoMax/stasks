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

  updateTask(Task newTask){
    repository.updateTask(newTask);
    List<Task> list = repository.getTasksByDay(state.selectedDay);
    emit(TaskListState(selectedDay: state.selectedDay, list: list));
  }

  createTask(TaskDTO newTask){
    repository.createTask(newTask);
    List<Task> list = repository.getTasksByDay(state.selectedDay);
    emit(TaskListState(selectedDay: state.selectedDay, list: list));
  }
}

class TaskListState{
  final DateTime selectedDay;
  final List<Task> list;
  TaskListState({required this.selectedDay, required this.list});
}