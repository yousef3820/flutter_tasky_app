import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tasky_app/core/components/custom_text_form_field.dart';
import 'package:flutter_tasky_app/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool isHighPirority = false;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 50),
                CustomTextFormField(
                  title: 'Task Name',
                  hintText: 'Finish UI design for login screen',
                  controller: taskNameController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter your Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Task Description",
                  hintText:
                      'Finish onboarding UI and hand off to devs by Thursday.',
                  maxlines: 5,
                  controller: taskDescriptionController,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "High Priority",
                      style: TextTheme.of(context).bodyMedium,
                    ),
                    Switch(
                      value: isHighPirority,
                      onChanged: (bool value) {
                        setState(() {
                          isHighPirority = value;
                        });
                      },
                      activeColor: Color(0xFFFFFCFC),
                      activeTrackColor: Color(0xFF15B86C),
                    ),
                  ],
                ),
                SizedBox(height: 177),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      final String? list = pref.getString('tasks');
                      List <dynamic> listTasks = [];
                      if(list != null)
                      {
                        listTasks =  jsonDecode(list);
                      }
                      TaskModel taskmodel =TaskModel(id: listTasks.length + 1, title: taskNameController.text, description: taskDescriptionController.text, isHighPriority: isHighPirority ,isDone: false,);
                      listTasks.add(taskmodel.toMap());
                      String value = jsonEncode(listTasks);
                      await pref.setString('tasks', value);
                      taskNameController.clear();
                      taskDescriptionController.clear();
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
