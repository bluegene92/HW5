import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _textFieldController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    var today = DateTime.now();
    final DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: today.add(const Duration(days: 3)),
        firstDate: today.add(const Duration(days: -1)),
        lastDate: today.add(const Duration(days: 1000)));

    setState(() {
      _selectedDate = pickDate;
    });
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
          TextField(controller: _textFieldController),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () => _selectDate(context),
              child: Text(_selectedDate == null
                  ? "Select Due Date"
                  : DateFormat("M/d/yyyy").format(_selectedDate!))),
          const SizedBox(height: 5),
          FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: const Text('Save'),
              onPressed: () {
                NewTaskPageResult result =
                    NewTaskPageResult(_textFieldController.text, _selectedDate);
                //on save, update the storage/model
                Navigator.pop(context, result);
              })
        ],
      ),
    );
  }
}

class NewTaskPageResult {
  String? text = "";
  DateTime? dueDate;

  NewTaskPageResult(this.text, this.dueDate);
}
