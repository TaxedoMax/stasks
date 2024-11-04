import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/bloc/calendar_cubit.dart';
import 'package:stasks/src/widget/main_page/task_item.dart';

import '../../bloc/task_list_cubit.dart';
import '../../entity/task.dart';

class TaskListWidget extends StatefulWidget{
  const TaskListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskListWidget>{

  _calendarListener(BuildContext context, CalendarState state){
    if(state.selectedDay != BlocProvider.of<TaskListCubit>(context).state.selectedDay){
      BlocProvider.of<TaskListCubit>(context).loadByDay(state.selectedDay);
    }
  }

  _onReorder(int oldIndex, int newIndex, List<Task> list){
    Task oldTask = list[oldIndex];
    int tmpIndex = newIndex;
    // For smooth animation
    setState(() {
      if (oldIndex < tmpIndex) {
        tmpIndex -= 1;
      }
      final Task item = list.removeAt(oldIndex);
      list.insert(tmpIndex, item);
    });

    Task newTask = oldTask.copyWith(position: newIndex);
    debugPrint(oldTask.position.toString());
    BlocProvider.of<TaskListCubit>(context).updateTaskPosition(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarCubit, CalendarState>(
        listener: _calendarListener,

        child: BlocBuilder<TaskListCubit, TaskListState>(
          builder: (context, taskListState) {
            return ReorderableListView(
                padding: const EdgeInsets.all(10),
                buildDefaultDragHandles: false,
                
                onReorder: (int oldIndex, int newIndex) {
                  _onReorder(oldIndex, newIndex, taskListState.list);
                },

                children: <Widget>[
                  for(int index = 0; index < taskListState.list.length; index++)
                    Stack(
                      key: Key(index.toString()),
                      alignment: AlignmentDirectional.center,
                      children: [
                        TaskItem(task: taskListState.list[index]),
                        Positioned(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height,
                          child: ReorderableDragStartListener(
                              index: index,
                              child: const ColoredBox(color: Color.fromARGB(0, 0, 0, 0))
                          ),
                        ),
                      ],
                    )
                ],
            );
          }
        )
    );
  }

}