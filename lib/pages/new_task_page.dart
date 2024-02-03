import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  //wrap the Scaffold in
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add New Task'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const Text('New Task'),
          TextField(controller: textFieldController),
          const SizedBox(height: 5),
          FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: const Text('Save'),
              onPressed: () {
                //on save, update the storage/model
                Navigator.pop(context, textFieldController.text);
              })
        ],
      ),
    );
  }
}
