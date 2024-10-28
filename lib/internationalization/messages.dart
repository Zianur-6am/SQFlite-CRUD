import 'package:get/get.dart';

class Messages extends Translations{


  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US' : {
      'add_task' : 'Add Task',
      'update_task' : 'Update Task',
      'title' : 'Title',
      'description' : 'Description',
      'no_task' : 'No Task found',
    }
  };



}