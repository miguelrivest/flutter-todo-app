import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.black,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 20.0)
      ),
      useMaterial3: true,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const MyHomePage(title: 'Simple To-Do App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _submittedItems = [];

  void _handleSubmittedText(String text) {
    setState(() {
      _submittedItems.add(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack( // Use Stack to allow absolute positioning
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
                Expanded( // Make the ListView take available space
                  child: _submittedItems.isEmpty
                      ? Center( // Optional: Show a message when the list is empty
                    child: Text(
                      'No tasks yet! Add one below.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: _submittedItems.length,
                    itemBuilder: (context, index) {
                      final item = _submittedItems[index];
                      return ToDoItem(
                        title: item,
                        onDelete: () {
                          setState(() {
                            // Use removeAt(index) for more reliable deletion
                            _submittedItems.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned( // Position the TextField at the bottom
            left: 30.0,
            right: 30.0,
            bottom: 15.0,
            child: MyTextField(
              onSubmitted: _handleSubmittedText, // Pass the callback function
            ),
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  final Function(String) onSubmitted;

  const MyTextField({super.key, required this.onSubmitted});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // ToDoItem _newItem = ToDoItem(title: '');
  String _todoText = '';


  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Add a FocusNode

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode, // Assign the FocusNode
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
              // Call the callback function with the submitted text
              widget.onSubmitted(value);
              // Clear the text field after submission
              _controller.clear();
              _focusNode.requestFocus(); // Request focus after submission
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_task), // Use a suitable submitted icon
          onPressed: () {
            // Call the callback function with the submitted text
            widget.onSubmitted(_todoText);
            // Clear the text field after submission
            _controller.clear();
            _todoText = ''; // Reset the internal state as well
            _focusNode.requestFocus(); // Request focus after submission
          },
        ),
      ],
    );
  }
}

class ToDoItem extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  const ToDoItem({super.key, required this.title, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ],
    );
  }

}
