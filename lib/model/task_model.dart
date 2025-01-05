import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final String description;
  final DateTime? completedByDate;
  final TimeOfDay? completedByTime;
  final String? priority;
  final String status;
  final String? docId;
  final String? userId;
  final DateTime createdAt;

  TaskModel({
    required this.title,
    required this.description,
    this.completedByDate,
    this.completedByTime,
    this.priority,
    required this.status,
    this.docId,
    this.userId,
    required this.createdAt,
  });

  /// CopyWith method to update fields
  TaskModel copyWith({
    String? title,
    String? description,
    DateTime? completedByDate,
    TimeOfDay? completedByTime,
    String? priority,
    String? status,
    String? docId,
    String? userId,
    DateTime? createdAt,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      completedByDate: completedByDate ?? this.completedByDate,
      completedByTime: completedByTime ?? this.completedByTime,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completedByDate': completedByDate?.toIso8601String(),
      'completedByTime': completedByTime != null
          ? '${completedByTime!.hour}:${completedByTime!.minute}'
          : null,
      'priority': priority,
      'status': status,
      'docId': docId,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create from Map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      completedByDate: map['completedByDate'] != null
          ? DateTime.parse(map['completedByDate'])
          : null,
      completedByTime: map['completedByTime'] != null
          ? _parseTimeOfDay(map['completedByTime'])
          : null,
      priority: map['priority'],
      status: map['status'] ?? '',
      docId: map['docId'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  /// Helper to parse TimeOfDay
  static TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  String toString() {
    return 'TaskModel(title: $title, description: $description, completedByDate: $completedByDate, completedByTime: $completedByTime, priority: $priority, status: $status, docId: $docId, userId: $userId, createdAt: $createdAt)';
  }
}
