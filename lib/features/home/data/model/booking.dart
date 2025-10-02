import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String id;
  final String userId;
  final String sessionId;
  final String sessionType;
  final DateTime sessionStartTime;
  final DateTime sessionEndTime;
  final DateTime bookingDate;
  final String status;

  BookingModel({
    this.id = '',
    required this.userId,
    required this.sessionId,
    required this.sessionType,
    required this.sessionStartTime,
    required this.sessionEndTime,
    required this.bookingDate,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userId: json['userId'] as String,
      sessionId: json['sessionId'] as String,
      sessionType: json['sessionType'] as String,
      sessionStartTime: (json['sessionStartTime'] as Timestamp).toDate(),
      sessionEndTime: (json['sessionEndTime'] as Timestamp).toDate(),
      bookingDate: (json['bookingDate'] as Timestamp).toDate(),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'sessionId': sessionId,
      'sessionType': sessionType,
      'sessionStartTime': Timestamp.fromDate(sessionStartTime),
      'sessionEndTime': Timestamp.fromDate(sessionEndTime),
      'bookingDate': Timestamp.fromDate(bookingDate),
      'status': status,
    };
  }
}
