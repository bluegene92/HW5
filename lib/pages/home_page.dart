import 'package:flutter/material.dart';
import 'package:hw4/pages/new_task_page.dart';
import '../controllers/task_controller.dart';
import '../model/task.dart';

//       Class: Mobile Application Development
//        Name: Dat Tran
//        Date: Feb 2, 2024
//    Homework: Week 5
//      Points: 100 pts
//         Due: Feb 15, 2024

// Estimate Completion time: 4 Hours
// Actual Completition time: 3 Hours

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _initTaskController() async {
    await TaskController().initialize();
  }

  @override
  Widget build(BuildContext context) {
    //need to wrap in futurebuilder to initalize async TaskController....
    return FutureBuilder<void>(
        future: _initTaskController(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return StreamBuilder<List<Task>>(
            stream: TaskController()
                .getStream(), //since getStream is async, needs to wait for TaskController init first
            builder: ((context, snapshot) {
              // if (!snapshot.hasData) {
              //   return Scaffold(
              //     appBar: AppBar(title: const Text('Todo')),
              //     body: const CircularProgressIndicator(),
              //   );
              // }

              if (!snapshot.hasData) {
                print('no data');
              }

              print("snapshotdata: $snapshot.data");
              final tasks = snapshot.data ?? [];

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Todo'),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  actions: [
                    IconButton(
                        onPressed: () {
                          tasks.where((t) => t.isCompleted).forEach(
                              (task) => TaskController().removeTask(task));
                        },
                        icon: const Icon(Icons.delete))
                  ],
                ),
                body: ListView.separated(
                  itemBuilder: (_, index) => _toWidget(tasks[index]),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: tasks.length,
                ),
                floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewTaskPage()));

                      if (result != "" && result != null) {
                        var newTask = Task(description: result);
                        await TaskController().insertTask(newTask);
                      }
                    },
                    child: const Icon(Icons.add, color: Colors.white)),
              );
            }),
          );
        });
  }

  Widget _toWidget(Task task) {
    return CheckboxListTile(
        checkColor: Colors.white,
        activeColor: Colors.blue,
        title: Text(task.description),
        value: task.isCompleted,
        onChanged: (bool? value) {
          TaskController().updateTask(task);
        });
  }
}

Future<void> createController() async {
  await TaskController().initialize();
}
