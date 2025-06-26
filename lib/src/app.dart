import 'package:flutter/material.dart';
import 'package:flutter_app/src/config/theme.dart';
import 'package:flutter_app/src/features/todo/views/todo_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const ToDoPage(title: 'Simple To-Do App'),
    );
  }
}
