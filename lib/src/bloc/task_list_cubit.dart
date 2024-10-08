import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stasks/src/DTO/task_dto.dart';
import 'package:stasks/src/use_case/task_use_case.dart';

import '../entity/task.dart';

class TaskListCubit extends Cubit<TaskListState>{

  final TaskUseCase _taskUseCase = GetIt.I.get<TaskUseCase>();

  TaskListCubit() :super(TaskListState.initial());

  _emitChanges(DateTime day, TaskListAction type){
    List<Task> list = _taskUseCase.getTasksByDay(day);
    list.sort((a, b) => a.position.compareTo(b.position));
    emit(TaskListState(selectedDay: day, list: list, lastAction: type));
  }

  loadByDay(DateTime day){
    _emitChanges(day, TaskListAction.taskListLoaded);
  }

  updateTaskContent(Task newTask) async {
    await _taskUseCase.updateTaskContent(newTask);
    _emitChanges(state.selectedDay, TaskListAction.taskUpdated);
  }

  updateTaskPosition(Task newTask) async {
    await _taskUseCase.updateTaskPosition(newTask);
    _emitChanges(state.selectedDay, TaskListAction.taskUpdated);
  }

  createTask(TaskDTO newTask) async {
    await _taskUseCase.createTask(newTask);
    _emitChanges(state.selectedDay, TaskListAction.taskCreated);
  }

  deleteTask(int id) async {
    await _taskUseCase.deleteTaskById(id);
    _emitChanges(state.selectedDay, TaskListAction.taskDeleted);
  }

  shiftOutdatedTasks(DateTime day){
    _taskUseCase.shiftOutdatedTasks(day);
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