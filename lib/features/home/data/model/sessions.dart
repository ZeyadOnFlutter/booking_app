import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String id;
  final String type;
  final DateTime startTime;
  final DateTime endTime;
  final int capacity;

  SessionModel({
    required this.id,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.capacity,
  });

  factory SessionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SessionModel(
      id: json['id'],
      type: json['type'] as String,
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      capacity: json['capacity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'capacity': capacity,
    };
  }
}
