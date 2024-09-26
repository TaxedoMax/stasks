import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/widget/global/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/calendar_cubit.dart';
import '../widget/main_page/task_list_widget.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("STasks")),

      body: BlocProvider<CalendarCubit>(
          create: (BuildContext context)
            => CalendarCubit(DateTime.now(), CalendarFormat.week),

          child: const Column(
            children: [
              CalendarWidget(isFormatChanging: true),
              Expanded(child: TaskListWidget())
            ],
          )
      ),
    );
  }

}