import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isFavorite; // New field
  final Timestamp createdAt;
  final String startDate;
  final String startTime;
  final String endTime;
  final String deadline;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isFavorite = false, // Default value
    required this.createdAt,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.deadline,
  });

  factory Task.fromFirestore(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      isFavorite: data['isFavorite'] ?? false, // Parse from Firestore
      createdAt: data['createdAt'] as Timestamp,
      startDate: data['startDate'] ?? 'N/A',
      startTime: data['startTime'] ?? 'N/A',
      endTime: data['endTime'] ?? 'N/A',
      deadline: data['deadline'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite, // Include in Firestore document
      'createdAt': createdAt,
      'startDate': startDate,
      'startTime': startTime,
      'endTime': endTime,
      'deadline': deadline,
    };
  }
}
