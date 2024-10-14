
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


  // late DatabaseService _databaseService;
  // List<Tasks> tasks = [];



  @override
  void initState() {
    super.initState();
    // _databaseService = DatabaseService.instance;
    // _fetchProducts();
    setState(() {

    });
  }

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
          Get.toNamed('/add_task');
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
                            onTap: () async{
                              await Get.toNamed('/update_task',
                              arguments: {
                                'title' : task.title,
                                'description' : task.description,
                                'id' : task.id,
                                'status' : task.status
                              },
                              );

                              Get.back();

                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text("Delete Task"),
                            onTap: (){
                              _databaseService.deleteTask(task.id);
                              setState(() {

                              });

                              Get.back();
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
              title: Text(task!.title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              subtitle: Text(task.description, style: TextStyle(fontSize: 14),),
              trailing: Checkbox(
                  //assigning the value to the ui
                  value: task.status == 1,
                  onChanged: (val){
                    _databaseService.updateTaskStatus(task.id, task.title, task.description,  (val == true ? 1 : 0));
                    setState(() {
                    });
                  }),
              contentPadding: EdgeInsets.all(10),
              shape: Border(
                bottom: BorderSide(),
              ),
            );

      });
    });
  }
}
