import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/bloc/calendar_cubit.dart';
import 'package:stasks/src/repository/task_repository_impl.dart';
import 'package:stasks/src/widget/global/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class DateAlertDialog extends StatefulWidget{
  const DateAlertDialog({super.key, required this.oldSelectedDate});

  final DateTime oldSelectedDate;

  @override
  State<StatefulWidget> createState() => _DateAlertDialogState();
}

class _DateAlertDialogState extends State<DateAlertDialog>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarCubit>(
      create: (context)
        => CalendarCubit(widget.oldSelectedDate, CalendarFormat.month, TaskRepositoryImpl()),

      child: Builder(
        builder: (context) {
          return AlertDialog(
            title: const Text('Дата'),

            content: const SizedBox(
                height: 395,
                width: 300,
                child: CalendarWidget(isFormatChanging: false)
            ),

            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(widget.oldSelectedDate),
                child: const Text('Отмена')
              ),

              TextButton(
                  onPressed: () => Navigator.of(context)
                      .pop(BlocProvider.of<CalendarCubit>(context).state.selectedDay),
                  child: const Text('Подтвердить')
              ),
            ],
          );
        }
      ),
    );
  }

}