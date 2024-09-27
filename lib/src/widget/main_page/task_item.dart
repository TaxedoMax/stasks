import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/bloc/task_list_cubit.dart';
import 'package:stasks/src/page/task_page.dart';

import '../../entity/task.dart';

class TaskItem extends StatefulWidget{
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>{

  _suspendTask(){
    DateTime newDate = widget.task.date.add(const Duration(days: 1));
    Task newTask = widget.task.copyWith(date: newDate);
    BlocProvider.of<TaskListCubit>(context).updateTask(newTask);
  }

  _editTask(){
    TaskListCubit bloc = BlocProvider.of<TaskListCubit>(context);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            BlocProvider.value(
                value: bloc,
                child: TaskPage(mode: PageMode.edit, task: widget.task)
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
          children: [
            Checkbox(
                value: widget.task.isDone,
                onChanged: (isDone) => BlocProvider
                    .of<TaskListCubit>(context)
                    .updateTask(widget.task.copyWith(isDone: isDone)),
            ),

            const SizedBox(width: 10),

            Text(widget.task.name),
            
            const Spacer(),

            IconButton(
              onPressed: _suspendTask,
              icon: const Icon(Icons.more_time)
            ),

            IconButton(
              onPressed: _editTask,
              icon: const Icon(Icons.edit)
            )
          ],
        )
    );
  }
}