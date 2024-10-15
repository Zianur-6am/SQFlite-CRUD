
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_practice_project/controllers/task_controllers.dart';

import '../Models/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task List", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed('/add_task');
        },
        child: Icon(Icons.add),
      ),
      body: Obx(() {
        if(taskController.tasks.isEmpty){
          return Center(child: Text('No task found'),);
        }
        return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index){

              Tasks task = taskController.tasks[index];

              return ListTile(
                onTap: (){
                  Get.bottomSheet(
                      Container(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text("Edit Task"),
                              onTap: () {

                                Get.back();

                                //passing object to another screen
                                Get.toNamed('/update_task',
                                  arguments: task
                                );



                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text("Delete Task"),
                              onTap: (){
                                taskController.deleteTaskController(task.id);
                                // setState(() {
                                //
                                // });

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
                title: Text(task!.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                subtitle: Text(task.description, style: TextStyle(fontSize: 14),),
                trailing: Checkbox(
                  //assigning the value to the ui
                    value: task.status == 1,
                    onChanged: (val){
                      taskController.updateTaskController(task.id, task.title, task.description,  (val == true ? 1 : 0));
                      // setState(() {
                      // });
                    }),
                contentPadding: EdgeInsets.all(10),
                shape: const Border(
                  bottom: BorderSide(),
                ),

              );

        });
      })

    );
  }

}
