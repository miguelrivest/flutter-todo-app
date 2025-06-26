import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_app/src/features/todo/models/todo_item.dart';
import 'package:flutter_app/src/features/todo/widgets/add_todo_text_field.dart';
import 'package:flutter_app/src/features/todo/widgets/todo_item_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key, required this.title});

  final String title;

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final _todosBox = Hive.box('todos');

  void _handleSubmittedText(String text) {
    _todosBox.add(ToDoItem(title: text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks to do:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _todosBox.listenable(),
                      builder: (context, box, widget) {
                        if (box.values.isEmpty) {
                          return Center(
                            child: Text(
                              'No tasks yet! Add one below.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          );
                        }
                        final todos = box.values.toList().cast<ToDoItem>();
                        todos.sort((a, b) {
                          if (a.isCompleted && !b.isCompleted) {
                            return 1;
                          } else if (!a.isCompleted && b.isCompleted) {
                            return -1;
                          }
                          return 0;
                        });
                        return ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return ToDoItemWidget(
                              todo: todo,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 30.0,
              right: 30.0,
              bottom: 15.0,
              child: AddToDoTextField(
                onSubmitted: _handleSubmittedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
