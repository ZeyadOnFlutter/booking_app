class SessionEntity {
  final String id;
  final String type;
  final DateTime startTime;
  final DateTime endTime;
  final int capacity;

  SessionEntity({
    required this.id,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.capacity,
  });
}
