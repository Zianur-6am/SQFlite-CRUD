import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite_crud_practice_project/Models/tasks.dart';
import 'package:sqflite_crud_practice_project/services/database_service.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  final DatabaseService _databaseService = DatabaseService.instance;

  static Map<String,dynamic> arguments = Get.arguments ?? {};
  String title = arguments['title'] ??'';
  String description = arguments['description'] ?? '';
  int id = arguments['id'] ?? '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: title,
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
              initialValue: description,
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

                  // setState(() {
                  //   title = "";
                  // });


                  // //Terminating the dialog
                  // Navigator.pop(context);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text("Sending Message"),));
                }
              },
              child: Text("Update Task"),
            ),
          ],
        ),
      ),
    );
  }
}
