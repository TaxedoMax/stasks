import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stasks/src/bloc/task_list_cubit.dart';
import 'package:stasks/src/widget/edit_task_page/date_alert_dialog.dart';

import '../entity/task.dart';

class EditTaskPage extends StatefulWidget{
  final Task task;

  const EditTaskPage({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage>{
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

  void _acceptChanges(){
    Task newTask = widget.task.copyWith(
      name: _nameController.text,
      description: _descriptionController.text,
      date: _date
    );

    BlocProvider.of<TaskListCubit>(context).updateTask(newTask);

    Navigator.of(context).pop();
  }

  @override
  void initState(){
    super.initState();
    _date = widget.task.date;
    _nameController.text = widget.task.name;
    _descriptionController.text = widget.task.description;
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
              onPressed: _acceptChanges,
              child: const Text('Изменить'),
            )
          ],
        ),
      ),
    );
  }

}