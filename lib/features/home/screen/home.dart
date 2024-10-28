import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_practice_project/controllers/task_controllers.dart';

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
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          title: const Text(
            "Task List",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add_task');
          },
          child: const Icon(Icons.add),
        ),
        body: Obx(() {
          // print('==============>${taskController.taskList.length}');
          return CustomScrollView(
            // shrinkWrap: true,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.blue,
                floating: true,
                pinned: false,
                collapsedHeight: 80,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3,
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 20,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 4),
                                child: TextField(
                                  textInputAction: TextInputAction.go,
                                  onChanged: taskController.filterTaskByName,
                                  decoration: InputDecoration(
                                    hintText: "search_task".tr,
                                    hintStyle: TextStyle(color: Colors.black38),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black38,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (taskController.taskList.isEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                      height: 400,
                      child: Center(
                        child: Text(
                          'no_task'.tr,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                )
              else
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: taskController.taskList.length,
                    (BuildContext context, int index) {
                      var task = taskController.taskList[index];
                      return InkWell(
                        splashColor: Theme.of(context).primaryColorLight,
                        onTap: () {
                          //passing object to another screen
                          Get.toNamed('/update_task', arguments: task);
                        },
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.blue,
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        taskController
                                            .deleteTaskController(task.id);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                  Checkbox(
                                      //assigning the value to the ui
                                      value: task.status == 1,
                                      onChanged: (val) {
                                        taskController.updateTaskController(
                                            task.id,
                                            task.title,
                                            task.description,
                                            (val == true ? 1 : 0));
                                        // setState(() {
                                        // });
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          decoration: task.status == 1 ? TextDecoration.lineThrough : TextDecoration.none),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Text(
                                      task.description,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 14,
                                          decoration: task.status == 1 ? TextDecoration.lineThrough : TextDecoration.none),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
            ],
          );

          ///without SliverAppBar and Gridview

          // return SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       Container(
          //         color: Colors.blue,
          //         padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          //         child: Card(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //           elevation: 20,
          //           color: Colors.white,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8),
          //             child: Row(
          //               children: [
          //                 Expanded(
          //                   flex: 6,
          //                   child: Padding(
          //                     padding: const EdgeInsets.only(left: 10),
          //                     child: TextField(
          //                       textInputAction: TextInputAction.go,
          //                       onChanged: taskController.filterTaskByName,
          //                       decoration: const InputDecoration(
          //                         hintText: "Search Task by Name",
          //                         hintStyle: TextStyle(color: Colors.black38),
          //                         border: InputBorder.none,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 const Expanded(
          //                     flex: 1,
          //                     child: Icon(
          //                       Icons.search,
          //                       color: Colors.black38,
          //                     )),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       if(taskController.taskList.isEmpty)
          //         SizedBox(
          //           height: 400,
          //           child: Center(
          //             child: Text('no_task'.tr, style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),),
          //           )
          //         )
          //       else ListView.builder(
          //           itemCount: taskController.taskList.length,
          //           scrollDirection: Axis.vertical,
          //           shrinkWrap: true,
          //           itemBuilder: (context, index) {
          //             Tasks task = taskController.taskList[index];
          //
          //             return Card(
          //               elevation: 10,
          //               shadowColor: Colors.blue,
          //               margin: const EdgeInsets.all(8),
          //               child: ListTile(
          //                 onTap: () {
          //                   Get.bottomSheet(
          //                       Wrap(
          //                         children: [
          //                           ListTile(
          //                             leading: const Icon(Icons.edit),
          //                             title: const Text("Edit Task"),
          //                             onTap: () {
          //                               Get.back();
          //
          //                               //passing object to another screen
          //                               Get.toNamed('/update_task',
          //                                   arguments: task);
          //                             },
          //                           ),
          //                           ListTile(
          //                             leading: const Icon(Icons.delete),
          //                             title: const Text("Delete Task"),
          //                             onTap: () {
          //                               taskController
          //                                   .deleteTaskController(task.id);
          //                               // setState(() {
          //                               //
          //                               // });
          //
          //                               Get.back();
          //                             },
          //                           )
          //                         ],
          //                       ),
          //
          //                       //properties of bottomsheet
          //
          //                       // barrierColor: Colors.blue,
          //                       backgroundColor: Colors.orange,
          //                       shape: const RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.only(
          //                             topLeft: Radius.circular(10),
          //                             topRight: Radius.circular(10)),
          //                         //borderRadius: BorderRadius.circular(10),
          //                       ));
          //                 },
          //                 title: Text(
          //                   task.title,
          //                   style: const TextStyle(
          //                       fontSize: 20, fontWeight: FontWeight.bold),
          //                 ),
          //                 subtitle: Text(
          //                   task.description,
          //                   style: const TextStyle(fontSize: 14),
          //                 ),
          //                 trailing: Checkbox(
          //                     //assigning the value to the ui
          //                     value: task.status == 1,
          //                     onChanged: (val) {
          //                       taskController.updateTaskController(
          //                           task.id,
          //                           task.title,
          //                           task.description,
          //                           (val == true ? 1 : 0));
          //                       // setState(() {
          //                       // });
          //                     }),
          //                 contentPadding: const EdgeInsets.all(10),
          //               ),
          //             );
          //           }),
          //     ],
          //   ),
          // );
        }));
  }
}
