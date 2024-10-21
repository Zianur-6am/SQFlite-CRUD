import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_practice_project/controllers/task_controllers.dart';


class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {


  final TaskController taskController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();



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
                  decoration: InputDecoration(labelText: 'title'.tr, border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter Title';
                    return null;
                  },
            
                ),
                const SizedBox(height: 10,),
            
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'description'.tr, border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter a description.';
                    return null;
                  },
            
                ),
                ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {

                        taskController.addTaskController(titleController.text, descriptionController.text);
                        Get.back();
                      }

                      ///without form validation
                      // if(titleController.text.replaceAll(' ', '') != "" &&
                      //     descriptionController.text.replaceAll(' ', '') != ""){
                      //
                      //   taskController.addTaskController(titleController.text, descriptionController.text);
                      //
                      //   Get.back();
                      // }
                      // else{
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text("Please fill the task"),));
                      // }
                    },
                    child: const Text("Add Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
