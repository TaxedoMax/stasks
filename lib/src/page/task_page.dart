import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stasks/src/DTO/TaskDTO.dart';
import 'package:stasks/src/bloc/task_list_cubit.dart';

import '../entity/task.dart';
import '../widget/task_page/date_alert_dialog.dart';

class TaskPage extends StatefulWidget{
  final Task? task;
  final PageMode mode;
  final DateTime? date;

  const TaskPage({super.key, this.task, this.date, required this.mode});

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late DateTime _date;

  void _dialogUpdateDate() async {
    DateTime? date = await showDialog<DateTime>(
        context: context,
        builder: (context) => DateAlertDialog(oldSelectedDate: _date)
    );

    if(date != null){
      setState(() {
        _date = date;
      });
    }
  }

  void _editTask(){
    Task newTask = widget.task!.copyWith(
      name: _nameController.text,
      description: _descriptionController.text,
      date: _date
    );

    BlocProvider.of<TaskListCubit>(context).updateTask(newTask);

    Navigator.of(context).pop();
  }

  void _createTask(){
    TaskDTO newTask = TaskDTO(
        name: _nameController.text,
        description: _descriptionController.text,
        date: _date
    );
    BlocProvider.of<TaskListCubit>(context).createTask(newTask);

    Navigator.of(context).pop();
  }

    void _onAcceptPressed(){
    if(widget.mode == PageMode.edit){
      _editTask();
    }
    else if(widget.mode == PageMode.add){
      _createTask();
    }
    else{
      throw Exception('Unexpected PageMode');
    }
  }

  @override
  void initState(){
    super.initState();

    if(widget.mode == PageMode.edit){
      _date = widget.task!.date;
      _nameController.text = widget.task!.name;
      _descriptionController.text = widget.task!.description;
    }
    else if(widget.mode == PageMode.add){
      _date = widget.date ?? DateTime.now();
    }
  }

  @override
  void dispose(){
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("STasks")),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text('Название'),
            TextField(
              controller: _nameController,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            const Text('Описание'),
            TextField(
              controller: _descriptionController,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('dd.MM.yyyy').format(_date)),
                IconButton(
                    onPressed: _dialogUpdateDate,
                    icon: const Icon(Icons.calendar_month)
                )
              ],
            ),

            const Spacer(),

            TextButton(
              onPressed: _onAcceptPressed,
              child: const Text('Подтвердить'),
            )
          ],
        ),
      ),
    );
  }
}

enum PageMode{
  add,
  edit
}