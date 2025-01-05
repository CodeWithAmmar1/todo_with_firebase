import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/model/task_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  /// Add data to a specific collection
  Future<void> addTaskToFirebase(TaskModel task) async {
    task = task.copyWith(
      userId: currentUser?.uid,
    );
    try {
      final taskRef = await _firestore
          .collection('alltask')
          .doc(currentUser?.uid)
          .collection('task')
          .add(task.toMap());
      await taskRef.update({'docId': taskRef.id});
    } catch (e) {
      log(e.toString());
    }
  }
}
