import 'package:flutter/material.dart';
import 'package:sqflite_crud_practice_project/services/database_service.dart';

class AddUpdateClass extends StatefulWidget {
  const AddUpdateClass({super.key});

  @override
  State<AddUpdateClass> createState() => _AddUpdateClassState();
}

class _AddUpdateClassState extends State<AddUpdateClass> {

  final DatabaseService _databaseService = DatabaseService.instance;

  String _task = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Product Name'),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a product name.';
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _task= value;
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
                  _task = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: (){
                  if(_task != null || _task != ""){
                    _databaseService.addTask(_task!);

                    setState(() {
                      _task = "";
                    });
                    //Terminating the dialog
                    Navigator.pop(context);
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
