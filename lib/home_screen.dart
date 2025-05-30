import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tasky_app/addTask_screen.dart';
import 'package:flutter_tasky_app/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasksList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasks = prefs.getString("tasks");
    if (tasks != null && tasks.isNotEmpty) {
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
      backgroundColor: Colors.black,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () async {
          await  Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTask()),
          );
          _getData();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(170, 40),
        ),
        icon: const Icon(Icons.add),
        label: const Text("Add New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/Thumbnail.png"),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Good Evening", style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 6),
                      const Text("One task at a time.\nOne step closer.", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const Spacer(),
                  SvgPicture.asset("assets/images/Light.svg", width: 34, height: 34),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Yuhuu ,Your work Is ",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    "almost done ! ",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset('assets/images/waving.svg'),
                ],
              ),
              const SizedBox(height: 16),
              Text("My Tasks", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: tasksList.length,
                  itemBuilder: (context, index) {
                    final task = tasksList[index];
                    return Container(
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
                            decoration: task.isDone ? TextDecoration.lineThrough : null,
                            decorationColor: Colors.grey,
                            fontWeight: FontWeight.w500,
                            color: task.isDone ?  Colors.grey: Colors.white,
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}