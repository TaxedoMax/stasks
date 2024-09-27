import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../bloc/calendar_cubit.dart';

class CalendarWidget extends StatefulWidget{
  final bool isFormatChanging;

  const CalendarWidget({super.key, required this.isFormatChanging});

  @override
  State<StatefulWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return TableCalendar(
          locale: 'ru_RU',
          headerStyle: const HeaderStyle(formatButtonVisible: false),
          startingDayOfWeek: StartingDayOfWeek.monday,

          firstDay: state.firstDay,
          lastDay: state.lastDay,
          currentDay: state.currentDay,
          focusedDay: state.focusedDay,
          calendarFormat: state.calendarFormat,

          selectedDayPredicate: (day) => isSameDay(state.focusedDay, day),

          onDaySelected: (selectedDay, focusedDay) =>
              BlocProvider.of<CalendarCubit>(context)
                  .selectDay(selectedDay, focusedDay),

          onFormatChanged: widget.isFormatChanging
              ? (format) => BlocProvider.of<CalendarCubit>(context).changeFormat(format)
              : null,
        );
      }
    );
  }

}