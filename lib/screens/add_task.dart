import 'package:flutter/material.dart';
import 'package:sqflite_crud_practice_project/services/database_service.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final DatabaseService _databaseService = DatabaseService.instance;

  String title = '';
  String description = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter Title';
                return null;
              },
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),

            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a description.';
                return null;
              },
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: (){
                  if(title != "" || description != ""){
                    _databaseService.addTask(title, description);

                    setState(() {
                      title = "";
                      description = "";
                    });

                    // //Terminating the dialog
                    // Navigator.pop(context);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text("Sending Message"),));
                  }
                },
                child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
