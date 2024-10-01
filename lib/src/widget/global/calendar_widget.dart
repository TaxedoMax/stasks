import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../bloc/calendar_cubit.dart';
import '../../bloc/task_list_cubit.dart';

class CalendarWidget extends StatefulWidget{
  final bool isFormatChanging;

  const CalendarWidget({super.key, required this.isFormatChanging});

  @override
  State<StatefulWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>{

  List<dynamic> _eventLoader(DateTime day){
    return BlocProvider.of<CalendarCubit>(context).getTasksByDay(day);
  }

  _updateCalendarState(CalendarState oldState){
    BlocProvider.of<CalendarCubit>(context)
        .selectDay(oldState.selectedDay, oldState.focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, calendarState) {
        return BlocListener<TaskListCubit, TaskListState>(
          listener: (context, state) {
            if(state.lastAction != TaskListAction.taskListLoaded) {
              _updateCalendarState(calendarState);
            }
          },
          child: TableCalendar(
            locale: 'ru_RU',
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            startingDayOfWeek: StartingDayOfWeek.monday,

            firstDay: calendarState.firstDay,
            lastDay: calendarState.lastDay,
            currentDay: calendarState.currentDay,
            focusedDay: calendarState.focusedDay,
            calendarFormat: calendarState.calendarFormat,

            eventLoader: _eventLoader,
            selectedDayPredicate: (day) => isSameDay(calendarState.focusedDay, day),

            onDaySelected: (selectedDay, focusedDay) =>
                BlocProvider.of<CalendarCubit>(context)
                    .selectDay(selectedDay, focusedDay),

            onFormatChanged: widget.isFormatChanging
                ? (format) => BlocProvider.of<CalendarCubit>(context).changeFormat(format)
                : null,

            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  shape: BoxShape.circle
              )
            )

          ),
        );
      }
    );
  }

}