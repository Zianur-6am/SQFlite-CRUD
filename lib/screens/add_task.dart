import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
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
              SizedBox(height: 10,),

              TextFormField(
                decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
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
                      Get.back();
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text("Please fill the task"),));
                    }
                  },
                  child: Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
