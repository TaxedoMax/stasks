import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stasks/src/page/task_page.dart';
import 'package:stasks/src/repository/mock_task_repository.dart';
import 'package:stasks/src/repository/task_repository_impl.dart';
import 'package:stasks/src/widget/global/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/calendar_cubit.dart';
import '../bloc/task_list_cubit.dart';
import '../widget/main_page/task_list_widget.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage>{

  void _openCreatePage(BuildContext context){
    CalendarCubit calendarCubit = BlocProvider.of<CalendarCubit>(context);
    TaskListCubit taskCubit = BlocProvider.of<TaskListCubit>(context);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            BlocProvider.value(
                value: taskCubit,
                child: TaskPage(
                    mode: PageMode.add,
                    date: calendarCubit.state.focusedDay
                )
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("STasks")),

      body: MultiBlocProvider(
          providers: [
            BlocProvider<CalendarCubit>(
              create: (BuildContext context)
                => CalendarCubit(DateTime.now(), CalendarFormat.week),
            ),

            BlocProvider<TaskListCubit>(
              create: (BuildContext context) =>
                TaskListCubit(TaskRepositoryImpl())
                  ..loadByDay(context.read<CalendarCubit>().state.focusedDay)
            )
          ],
          child: Stack(
            children: [
              const Column(
                children: [
                  CalendarWidget(isFormatChanging: true),
                  Expanded(child: TaskListWidget())
                ],
              ),
              Builder(
                builder: (context) {
                  return Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                          onPressed: () => _openCreatePage(context),
                          iconSize: 50,
                          icon: const Icon(Icons.add_circle)
                      )
                  );
                }
              )
            ],
          )
      ),
    );
  }

}