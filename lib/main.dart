import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stasks/src/page/main_page.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}




