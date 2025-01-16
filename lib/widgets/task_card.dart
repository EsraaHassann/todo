import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import '../providers/favorites_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function() onMark;
  final Function(Task) onEdit;
  final Function() onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onMark,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Favorite Icon
            IconButton(
              icon: Icon(
                task.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: task.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                // Toggle favorite status in Firebase
                favoritesProvider.toggleFavorite(task.id, !task.isFavorite);
              },
            ),
            // Edit Task Icon
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit(task),
            ),
            // Mark Complete/Undo Icon
            IconButton(
              icon: Icon(task.isCompleted ? Icons.undo : Icons.check),
              onPressed: onMark,
            ),
            // Delete Task Icon
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
