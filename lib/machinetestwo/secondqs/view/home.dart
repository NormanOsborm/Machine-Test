import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/task.dart';
import '../viewmodel/taskviewmodel.dart';
import 'addtask.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskViewModel viewModel = TaskViewModel();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text('Task App',style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),),
          bottom: const TabBar(
              tabs: [Tab(text: 'Pending Tasks'), Tab(text: 'Completed Tasks')]),
        ),
        body: TabBarView(
          children: [
            _buildTaskList(false),
            _buildTaskList(true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTaskList(bool isCompleted) {
    return FutureBuilder<List<Task>>(
      future: viewModel.getTasks(isCompleted),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final task = snapshot.data![index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!task.isCompleted)
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        task.isCompleted = true;
                        viewModel.updateTask(task).then((_) => setState(() {}));
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      viewModel
                          .deleteTask(task.id)
                          .then((_) => setState(() {}));
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
