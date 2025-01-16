import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Task> allTasks; // Pass the complete list of tasks here

  const FavoriteScreen({super.key, required this.allTasks});

  @override
  Widget build(BuildContext context) {
    // Filter tasks where isFavorite is true
    final favoriteTasks = allTasks.where((task) => task.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Tasks'),
      ),
      body: favoriteTasks.isEmpty
          ? const Center(child: Text('No favorite tasks yet!'))
          : ListView.builder(
              itemCount: favoriteTasks.length,
              itemBuilder: (context, index) {
                final task = favoriteTasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Remove favorite logic (if needed)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Remove favorites via task card.')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
