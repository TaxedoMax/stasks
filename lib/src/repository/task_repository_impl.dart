import 'package:hive/hive.dart';
import 'package:stasks/src/DTO/task_dto.dart';
import 'package:stasks/src/entity/task.dart';
import 'package:stasks/src/repository/task_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskRepositoryImpl extends TaskRepository{
  final _taskBox = Hive.box<Task>('box_for_task');

  @override
  Future<void> createTask(TaskDTO newTask) async {
    int position = getUnfinishedCountByDay(newTask.date);

    Task tmp = Task(
        id: -1,
        date: newTask.date,
        name: newTask.name,
        description: newTask.description,
        isDone: false,
        position: position
    );
    int id = await _taskBox.add(tmp);

    // Shifting finished tasks
    var list = getTasksByDay(newTask.date);
    for(var task in list){
      if(task.isDone){
        await updateTask(task.copyWith(position: task.position + 1));
      }
    }

    await _taskBox.put(id, tmp.copyWith(id: id));
  }

  @override
  Task getTaskById(int id){
    return _taskBox.get(id)!;
  }

  @override
  Future<void> deleteTaskById(int id) async {
    await _taskBox.delete(id);
  }

  @override
  List<Task> getTasksByDay(DateTime day) {
    List<Task> result = [];

    for(int i = 0; i < _taskBox.length; i++){
      Task current = _taskBox.getAt(i)!;

      if(isSameDay(current.date, day)){
        result.add(current);
      }
    }

    return result;
  }

  @override
  int getUnfinishedCountByDay(DateTime day){
    var list = getTasksByDay(day);
    int count = 0;

    for(Task task in list){
      if(!task.isDone){
        count++;
      }
    }
    return count;
  }

  @override
  int getFinishedCountByDay(DateTime day){
    var list = getTasksByDay(day);
    int count = 0;

    for(Task task in list){
      if(task.isDone){
        count++;
      }
    }
    return count;
  }

  @override
  Future<void> updateTask(Task newTask) async {
    await _taskBox.put(newTask.id, newTask);
  }

  @override
  List<Task> getAll() {
    List<Task> list = [];

    for(int i = 0; i < _taskBox.length; i++){
      list.add(_taskBox.getAt(i)!);
    }

    return list;
  }

}