class BookingEntity {
  String id;
  final String userId;
  final String sessionId;
  final String sessionType;
  final DateTime sessionStartTime;
  final DateTime sessionEndTime;
  final DateTime bookingDate;
  final String status;

  BookingEntity({
    this.id = '',
    required this.userId,
    required this.sessionId,
    required this.sessionType,
    required this.sessionStartTime,
    required this.sessionEndTime,
    required this.bookingDate,
    required this.status,
  });
}
