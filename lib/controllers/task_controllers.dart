import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_practice_project/services/database_service.dart';

class TaskController extends GetxController{

  var tasks = [].obs;

  // TextEditingController? title;
  // TextEditingController? description;


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadTask();
  }

  void loadTask() async {
    var taskList = await DatabaseService.instance.getTask();
    tasks.value = taskList!;
  }

  void addTaskController(String title, String description) async {
    DatabaseService.instance.addTask(title, description);
    loadTask();
  }

  void updateTaskController(int id, String title, String description, int status) async {

  print('id = $id, title = $title ++++++++++++++++++++++++++');
    DatabaseService.instance.updateTaskStatus(id, title, description, status);
    loadTask();
  }

  void deleteTaskController(int id) async {
    DatabaseService.instance.deleteTask(id);
    loadTask();
  }






}