import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _textFieldController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedDateText = "Selected Due Date";

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2101));

    if (pickDate != null && pickDate != _selectedDate) {
      setState(() {
        _selectedDate = pickDate;

        String day = pickDate.day.toString();
        String month = pickDate.month.toString().padLeft(2, '0');
        String year = pickDate.year.toString();

        _selectedDateText = "$month/$day/$year";
      });
    }
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
              child: Text(_selectedDateText)),
          const SizedBox(height: 5),
          FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: const Text('Save'),
              onPressed: () {
                //on save, update the storage/model
                Navigator.pop(
                    context, [_textFieldController.text, _selectedDate]);
              })
        ],
      ),
    );
  }
}
