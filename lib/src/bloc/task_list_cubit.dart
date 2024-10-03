import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/DTO/task_dto.dart';

import '../entity/task.dart';
import '../repository/task_repository.dart';

class TaskListCubit extends Cubit<TaskListState>{

  final TaskRepository repository;

  TaskListCubit(this.repository) :super(TaskListState.initial());

  _emitChanges(DateTime day, TaskListAction type){
    List<Task> list = repository.getTasksByDay(day);
    list.sort((a, b) => a.compareTo(b));
    emit(TaskListState(selectedDay: day, list: list, lastAction: type));
  }

  loadByDay(DateTime day){
    _emitChanges(day, TaskListAction.taskListLoaded);
  }

  updateTask(Task newTask) async {
    await repository.updateTask(newTask);
    _emitChanges(state.selectedDay, TaskListAction.taskUpdated);
  }

  createTask(TaskDTO newTask) async {
    await repository.createTask(newTask);
    _emitChanges(state.selectedDay, TaskListAction.taskCreated);
  }

  deleteTask(int id) async {
    await repository.deleteTaskById(id);
    _emitChanges(state.selectedDay, TaskListAction.taskDeleted);
  }
}

class TaskListState{
  final DateTime selectedDay;
  final List<Task> list;
  final TaskListAction lastAction;
  TaskListState({required this.selectedDay, required this.list, required this.lastAction});

  factory TaskListState.initial() => TaskListState(
      selectedDay: DateTime.now(),
      list: [],
      lastAction: TaskListAction.taskListLoaded
  );
}

enum TaskListAction{
  taskListLoaded,
  taskCreated,
  taskDeleted,
  taskUpdated,
}