import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/bloc/calendar_cubit.dart';
import 'package:stasks/src/widget/main_page/task_item.dart';
import 'package:stasks/src/repository/mock_task_repository.dart';

import '../../bloc/task_list_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarCubit, CalendarState>(
        listener: _calendarListener,

        child: BlocBuilder<TaskListCubit, TaskListState>(
          builder: (context, taskListState) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: taskListState.list.length,
                itemBuilder: (BuildContext context, int index){
                  return TaskItem(task: taskListState.list[index]);
                }
            );
          }
        )
    );
  }

}