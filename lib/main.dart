import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stasks/service_locator.dart';
import 'package:stasks/src/entity/task.dart';
import 'package:stasks/src/page/main_page.dart';
import 'package:stasks/src/style/default_text_theme.dart';

void main() async {
  await initHive();
  initOverlayStyle();
  initServiceLocator();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

void initOverlayStyle(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000)
    )
  );
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('box_for_task');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initOverlayStyle();

    return MaterialApp(
      title: 'STasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark
        ),
        textTheme: defaultTextTheme,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}




