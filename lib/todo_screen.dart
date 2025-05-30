import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tasky_app/models/task_model.dart'; 

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TaskModel> tasksList = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasks = prefs.getString("tasks");
    if (tasks != null && tasks.isNotEmpty ) {
      List<dynamic> value = jsonDecode(tasks);
      setState(() {
        tasksList = value.map((e) => TaskModel.fromMap(e)).toList();
      });
    }
  }
    void _toggleTask(int index) async {
    setState(() {
      tasksList[index].isDone = !tasksList[index].isDone;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tasks", jsonEncode(tasksList.map((e) => e.toMap()).toList()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                  child: ListView.builder(
                    itemCount: tasksList.length,
                    itemBuilder: (context, index) {
                      final task = tasksList[index];
                      return !task.isDone ?  Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2C2C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isDone,
                            onChanged: (_) => _toggleTask(index),
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color:  Colors.white
                            ),
                          ),
                          subtitle: task.description.isNotEmpty
                              ? Text(
                                  task.description,
                                  style: const TextStyle(color: Colors.white70),
                                )
                              : null,
                          trailing: const Icon(Icons.more_vert, color: Colors.white70),
                        ),
                      ) : const SizedBox.shrink() ;
                    },
                  ),
                ),
          ],
        ),
      )
    );
  }
}
