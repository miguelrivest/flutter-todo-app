import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_app/src/app.dart';
import 'package:flutter_app/src/features/todo/models/todo_item.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoItemAdapter());
  await Hive.openBox('todos');
  runApp(const MyApp());
}