
import 'package:flutter_to_do/db/db_helper.dart';
import 'package:flutter_to_do/models/tasks.dart';
import 'package:get/get.dart';


class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);

  }

  void getTasks() async{
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHelper.delete(task);
    getTasks();

  }

  Future<void> markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();

  }


}