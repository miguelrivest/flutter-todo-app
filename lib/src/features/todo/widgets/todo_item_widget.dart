import 'package:flutter/material.dart';
import 'package:flutter_app/src/features/todo/models/todo_item.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoItem todo;

  const ToDoItemWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {
          todo.isCompleted = value!;
          todo.save();
        },
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
          decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          decorationColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          todo.delete();
        },
      ),
      onTap: () {
        todo.isCompleted = !todo.isCompleted;
        todo.save();
      },
    );
  }
}
