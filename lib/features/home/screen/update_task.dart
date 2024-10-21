import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_practice_project/features/home/domain/model/tasks.dart';
import 'package:sqflite_crud_practice_project/controllers/task_controllers.dart';

class UpdateTask extends StatefulWidget {
  //final Tasks tasks;
  const UpdateTask({super.key});


  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  //must be final the key won't change
  final _formKey = GlobalKey<FormState>();


  //getting the taskController Object that was initialized in Home class
  final TaskController taskController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? title;
  String? description;
  int? id;
  int? status;

  @override
  void initState() {
    super.initState();

    //receiving data from another screen
    Tasks tasks = Get.arguments as Tasks;

    title = tasks.title;
    description = tasks.description;
    id = tasks.id;
    status = tasks.status;

    titleController.text = title ?? '';
    descriptionController.text = description ?? '';

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(

                  controller: titleController,
                  // initialValue: title,
                  decoration: InputDecoration(labelText: 'title'.tr, border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter Title';
                    return null;
                  },

                ),
                const SizedBox(height: 10,),

                TextFormField(
                  controller: descriptionController,
                  // initialValue: description,
                  decoration: InputDecoration(labelText: 'description'.tr, border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter a description.';
                    return null;
                  },

                ),

                ElevatedButton(
                  onPressed: (){
                    title = titleController.text.trim();
                    description = descriptionController.text.trim();

                    if(_formKey.currentState!.validate()){

                      taskController.updateTaskController(id!, title!, description!, status!);
                      Get.back();

                    }

                    ///without form validation
                    // if((title?.isNotEmpty ?? false) &&
                    //     (description?.isNotEmpty ?? false)){
                    //
                    //
                    //
                    //   taskController.updateTaskController(id!, title!, description!, status!);
                    //
                    //   Get.back();
                    // }
                    // else{
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text("Please Complete Task"),));
                    // }
                  },
                  child: const Text("Update Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}