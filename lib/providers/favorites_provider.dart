import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Toggle favorite status in Firebase
  Future<void> toggleFavorite(String taskId, bool isFavorite) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'isFavorite': isFavorite,
      });
      notifyListeners();
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }
}
