import 'package:get/get.dart';
import 'package:sqflite_crud_practice_project/helper/database_service.dart';

class TaskController extends GetxController {
  var taskList = [].obs;
  dynamic allTasks = [];

  // TextEditingController? title;
  // TextEditingController? description;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadTask();
  }

  void loadTask() async {
    allTasks = await DatabaseService.instance.getTask();
    taskList.value = allTasks!;
  }

  void addTaskController(String title, String description) async {
    DatabaseService.instance.addTask(title, description);
    loadTask();
  }

  void updateTaskController(
      int id, String title, String description, int status) async {
    // print('id = $id, title = $title ++++++++++++++++++++++++++');
    DatabaseService.instance.updateTaskStatus(id, title, description, status);
    loadTask();
  }

  void deleteTaskController(int id) async {
    DatabaseService.instance.deleteTask(id);
    loadTask();
  }

  // Function to filter products by price
  void filterTaskByName(String name) {

    // print('title = $name ++++++++++++++++++++++++++');

    if (name.isEmpty) {
      taskList.value = allTasks;
    } else {
      taskList.value = allTasks
          .where((task) =>
              task.title.toString().toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
  }
}
