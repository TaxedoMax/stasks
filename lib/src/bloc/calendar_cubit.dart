import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCubit extends Cubit<CalendarState>{
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;

  CalendarCubit(this.focusedDay, this.calendarFormat)
      :super(CalendarState.initial(focusedDay, calendarFormat));

  selectDay(DateTime selectedDay, DateTime focusedDay) {
      CalendarState newState = state
          .copyWith(selectedDay: selectedDay, focusedDay: focusedDay);

      emit(newState);
  }

  changeFormat(CalendarFormat format){
    CalendarState newState = state.copyWith(calendarFormat: format);
    emit(newState);
  }
}

@immutable
class CalendarState{
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime currentDay;
  final DateTime focusedDay;
  final DateTime selectedDay;

  final CalendarFormat calendarFormat;

  const CalendarState({
    required this.firstDay,
    required this.lastDay,
    required this.currentDay,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat
  });

  CalendarState copyWith({
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? currentDay,
    DateTime? focusedDay,
    DateTime? selectedDay,
    CalendarFormat? calendarFormat
  }){
    return CalendarState(
        firstDay: firstDay ?? this.firstDay,
        lastDay: lastDay ?? this.lastDay,
        currentDay: currentDay ?? this.currentDay,
        focusedDay: focusedDay ?? this.focusedDay,
        selectedDay: selectedDay ?? this.selectedDay,
        calendarFormat: calendarFormat ?? this.calendarFormat
    );
  }

  factory CalendarState.initial(DateTime focusedDay, CalendarFormat calendarFormat) {
    DateTime now = DateTime.now();
    return CalendarState(
      firstDay: DateTime(now.year - 1, now.month, now.day),
      lastDay: DateTime(now.year + 1, now.month, now.day),
      currentDay: now.copyWith(),
      focusedDay: focusedDay,
      selectedDay: focusedDay,
      calendarFormat: calendarFormat
    );
  }
}