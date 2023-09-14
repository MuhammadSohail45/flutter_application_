import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import 'task_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 132, 214, 121),
        appBar: AppBar(
          title: const Text(
            'To-Do List App',
          ),
          backgroundColor: Colors.amber,
        ),
        body: const TaskList(),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  Task task = taskProvider.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        taskProvider.removeTask(task.id);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TaskInput(),
        ),
      ],
    );
  }
}

class TaskInput extends StatefulWidget {
  const TaskInput({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Add a task',
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            String title = _controller.text.trim();
            if (title.isNotEmpty) {
              Provider.of<TaskProvider>(context, listen: false).addTask(title);
              _controller.clear();
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
