import 'package:flutter/material.dart';
import 'package:hw4/pages/new_task_page.dart';
import 'package:intl/intl.dart';
import '../controllers/task_controller.dart';
import '../model/task.dart';

//       Class: Mobile Application Development
//        Name: Dat Tran
//        Date: Feb 2, 2024
//    Homework: Week 5
//      Points: 100 pts
//         Due: Feb 15, 2024

// Estimate Completion time: 4 Hours
// Actual Completition time: 6 Hours

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var loaded = false;
  var tasks = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: TaskController()
          .getStream(), //since getStream is async, needs to wait for TaskController init first
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Todo')),
            body: const CircularProgressIndicator(),
          );
        }

        //separate local state from database state
        if (!loaded) {
          tasks = snapshot.data ?? [];
          loaded = true;
        }

        List<Widget> actions = [];
        if (tasks.any((task) => task.isCompleted)) {
          actions.add(IconButton(
              onPressed: () {
                tasks
                    .where((t) => t.isCompleted)
                    .forEach((task) => TaskController().removeTask(task));
                loaded = false; //allow to load data again
              },
              icon: const Icon(Icons.delete)));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: actions,
          ),
          body: ListView.separated(
            itemBuilder: (_, index) => _toWidget(tasks[index]),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: tasks.length,
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () async {
                NewTaskPageResult result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewTaskPage()));

                if (result.text?.trim().isEmpty ?? true) return;

                loaded = false; //allow to load data again
                var newTask =
                    Task(description: result.text!, dueDate: result.dueDate);
                await TaskController().insertTask(newTask);
              },
              child: const Icon(Icons.add, color: Colors.white)),
        );
      }),
    );
  }

  Widget _toWidget(Task task) {
    Widget? dueDate;
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

    if (task.dueDate != null) {
      dueDate = Text(DateFormat("M/d/yyyy").format(task.dueDate!),
          style: TextStyle(
              color: task.dueDate!.isBefore(yesterday)
                  ? Colors.red
                  : Colors.black));
    }

    return CheckboxListTile(
        checkColor: Colors.white,
        activeColor: Colors.blue,
        title: Text(task.description),
        subtitle: dueDate,
        value: task.isCompleted,
        onChanged: (bool? value) {
          setState(() {
            task.isCompleted = value!;
          });
        });
  }
}

Future<void> createController() async {
  await TaskController().initialize();
}
