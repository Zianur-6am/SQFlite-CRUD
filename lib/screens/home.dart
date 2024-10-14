
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sqflite_crud_practice_project/services/database_service.dart';

import '../Models/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _task = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task List"),),
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
                  Expanded(
                    child: TextField(
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
                  ),

                  MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if(_task != null || _task != ""){
                        // _databaseService.addTask(_task!);

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
                    child: const Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.black),
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
              onTap: (){
                Get.bottomSheet(
                    Container(
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text("Edit Task"),
                            onTap: (){
                              Get.toNamed('/update_task',
                              arguments: {
                                'title' : task.title,
                                'description' : task.description,
                                'id' : task.id,
                              });
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text("Delete Task"),
                            onTap: (){
                              Get.changeTheme(ThemeData.dark());
                            },
                          )
                        ],
                      ),
                    ),

                    //properties of bottomsheet

                    // barrierColor: Colors.blue,
                    backgroundColor: Colors.orange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      //borderRadius: BorderRadius.circular(10),
                    )
                );

              },
              onLongPress: (){
                _databaseService.deleteTask(task.id);
                setState(() {

                });
              },
              title: Text(task!.title),
              trailing:
              Checkbox(
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
