import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/task_dialog.dart';
import '../widgets/drawer_widget.dart'; 

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // Add Task to Firestore
  Future<void> addTask(Task task) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': task.title,
        'description': task.description,
        'isCompleted': false,
        'startDate': task.startDate,
        'startTime': task.startTime,
        'endTime': task.endTime,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error adding task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add task!')),
      );
    }
  }

  // Edit Task in Firestore
  Future<void> editTask(Task oldTask, Task newTask) async {
    try {
      final taskDoc = await FirebaseFirestore.instance
          .collection('tasks')
          .where('title', isEqualTo: oldTask.title)
          .get();

      if (taskDoc.docs.isNotEmpty) {
        await taskDoc.docs.first.reference.update({
          'title': newTask.title,
          'description': newTask.description,
        });
      }
    } catch (e) {
      debugPrint('Error editing task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to edit task!')),
      );
    }
  }

  // Delete Task from Firestore
  Future<void> deleteTask(Task task) async {
    try {
      final taskDoc = await FirebaseFirestore.instance
          .collection('tasks')
          .where('title', isEqualTo: task.title)
          .get();

      if (taskDoc.docs.isNotEmpty) {
        await taskDoc.docs.first.reference.delete();
      }
    } catch (e) {
      debugPrint('Error deleting task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete task!')),
      );
    }
  }

  // Mark Task as Completed/Incomplete
  Future<void> markTask(Task task) async {
    try {
      final taskDoc = await FirebaseFirestore.instance
          .collection('tasks')
          .where('title', isEqualTo: task.title)
          .get();

      if (taskDoc.docs.isNotEmpty) {
        await taskDoc.docs.first.reference.update({
          'isCompleted': !task.isCompleted,
        });
      }
    } catch (e) {
      debugPrint('Error marking task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update task status!')),
      );
    }
  }

  // Show Task Dialog for Adding/Editing Tasks
  void _showTaskDialog({Task? task}) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          task: task,
          onSave: (newTask) {
            if (task != null) {
              editTask(task, newTask); 
            } else {
              addTask(newTask); 
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 136, 185, 189),
        elevation: 0,
      ),
      drawer: const DrawerWidget(), // Drawer for navigation
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .orderBy('createdAt', descending: true) // Sort tasks by creation time
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }

          // Convert Firestore documents to Task objects
          final tasks = snapshot.data?.docs
                  .map((doc) => Task.fromFirestore(
                      doc.data() as Map<String, dynamic>, doc.id))
                  .toList() ??
              [];

          // Filter incomplete tasks
          final filteredTasks =
              tasks.where((task) => !task.isCompleted).toList();

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return TaskCard(
                task: task,
                onMark: () => markTask(task), // Toggle task completion
                onEdit: (task) => _showTaskDialog(task: task), // Edit task
                onDelete: () => deleteTask(task), // Delete task
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(), // Open dialog to add task
        backgroundColor: const Color.fromARGB(255, 136, 185, 189),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
