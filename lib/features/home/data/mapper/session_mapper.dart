import '../../domain/entities/session_entity.dart';
import '../model/sessions.dart';

extension SessionMapper on SessionModel {
  SessionEntity get toEntity => SessionEntity(
        id: id,
        type: type,
        startTime: startTime,
        endTime: endTime,
        capacity: capacity,
      );
}
