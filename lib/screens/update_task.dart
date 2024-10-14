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


  String title = arguments['title'] ?? '';
  String description = arguments['description'] ?? '';
  int id = arguments['id'] ?? '';
  int status = arguments['status'] ?? '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: title,
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
              initialValue: description,
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
                  _databaseService.updateTaskStatus(id, title, description, status);

                  Get.back();
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
