import 'package:flutter/material.dart';
import 'package:flutter_app/src/features/todo/models/todo_item.dart';

class ToDoItemWidget extends StatefulWidget {
  final ToDoItem todo;

  const ToDoItemWidget({super.key, required this.todo});

  @override
  State<ToDoItemWidget> createState() => _ToDoItemWidgetState();
}
class _ToDoItemWidgetState extends State<ToDoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {
          setState(() {
            widget.todo.isCompleted = value!;
            widget.todo.save();
          });
        },
      ),
      title: TextField(
        controller: TextEditingController(text: widget.todo.title),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          setState(() {
            widget.todo.title = value;
            widget.todo.save();
          });
        },
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
          decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          decorationColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          widget.todo.delete();
        },
      ),
      onTap: () {
        setState(() {
          widget.todo.isCompleted = !widget.todo.isCompleted;
          widget.todo.save();
        });
      },
    );
  }

  ToDoItem get todo => widget.todo;
}

