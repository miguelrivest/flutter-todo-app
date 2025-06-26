import 'package:hive/hive.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 0)
class ToDoItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  ToDoItem({required this.title, this.isCompleted = false});
}
