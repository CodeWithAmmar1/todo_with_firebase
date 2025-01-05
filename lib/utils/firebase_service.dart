import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/model/task_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

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

  Future<void> updateTaskToFirebase(TaskModel task) async {
    task = task.copyWith(
      userId: currentUser?.uid,
    );
    try {
      await _firestore
          .collection('alltask')
          .doc(currentUser?.uid)
          .collection('task')
          .doc(task.docId)
          .set(task.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteAllTaskToFirebase(List<String> ids) async {
    try {
      for (var docId in ids) {
        final taskQuery = await _firestore
            .collection('alltask')
            .doc(currentUser?.uid)
            .collection('task')
            .where('docId', isEqualTo: docId)
            .get();

        for (var doc in taskQuery.docs) {
          await doc.reference.delete();
        }
      }
      log('All specified tasks deleted successfully.');
    } catch (e) {
      log('Error deleting tasks: $e');
    }
  }

  Future<List<TaskModel>> getTaskFromFirebase(String statusTask) async {
    try {
      final snapshot = await _firestore
          .collection('alltask')
          .doc(currentUser?.uid)
          .collection('task')
          .where('status', isEqualTo: statusTask)
          .get();

      return snapshot.docs.map((doc) => TaskModel.fromMap(doc.data())).toList();
    } catch (e) {
      log('Error listening to tasks: $e');
      return [];
    }
  }

  Stream<List<TaskModel>> listenToTasksFromFirebase(String statusTask) {
    try {
      return _firestore
          .collection('alltask')
          .doc(currentUser?.uid)
          .collection('task')
          .where('status', isEqualTo: statusTask)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => TaskModel.fromMap(doc.data()))
            .toList();
      });
    } catch (e) {
      log('Error listening to tasks: $e');
      return const Stream.empty();
    }
  }
}
