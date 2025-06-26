import 'package:flutter/material.dart';

class AddToDoTextField extends StatefulWidget {
  final Function(String) onSubmitted;

  const AddToDoTextField({super.key, required this.onSubmitted});

  @override
  State<AddToDoTextField> createState() => _AddToDoTextFieldState();
}

class _AddToDoTextFieldState extends State<AddToDoTextField> {
  String _todoText = '';


  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: (text) {
              setState(() {
                _todoText = text;
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter text',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            onSubmitted: (String value) {
              if (value.isNotEmpty) {
                widget.onSubmitted(value);
                _controller.clear();
                _focusNode.requestFocus();
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_task),
          onPressed: () {
            if (_todoText.isNotEmpty) {
              widget.onSubmitted(_todoText);
              _controller.clear();
              _todoText = '';
              _focusNode.requestFocus();
            }
          },
        ),
      ],
    );
  }
}
