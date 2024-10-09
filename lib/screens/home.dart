import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_crud_practice_project/services/database_service.dart';

import '../Models/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _task = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addTaskButton(),
      body: _tasksList(),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(

              title: const Text("Add task"),
              content: Column( mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _task = value;
                      });
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Add Task",
                    ),
                  ),

                  MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if(_task != null || _task != ""){
                        _databaseService.addTask(_task!);

                        setState(() {
                          _task = null;
                        });
                        //Terminating the dialog
                        Navigator.pop(context);
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text("Sending Message"),));
                      }
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add));
  }

  _tasksList() {
    return FutureBuilder(future: _databaseService.getTask(), builder: (context, snapshot){
      return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index){
            Tasks? task = snapshot.data?[index];
            return ListTile(
              onLongPress: (){
                _databaseService.deleteTask(task.id);
                setState(() {

                });
              },
              title: Text(task!.content),
              trailing: Checkbox(
                  value: task.status == 1,
                  onChanged: (value){
                    _databaseService.updateTaskStatus(task.id, value == true ? 1 : 0);
                    setState(() {
                    });
                  }),
            );

      });
    });
  }
}
