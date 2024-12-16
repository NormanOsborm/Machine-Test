import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/task.dart';
import '../viewmodel/taskviewmodel.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TaskViewModel viewModel = TaskViewModel();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.opaqueSeparator,
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: "Title of you task",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
            const SizedBox(height: 20,),
            TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: "Add your task",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final task = Task(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                );
                viewModel.addTask(task).then((_) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Task Saved")),
                  );
                });
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
