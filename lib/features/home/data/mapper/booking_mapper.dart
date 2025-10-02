import '../../domain/entities/booking_entity.dart';
import '../model/booking.dart';

extension BookingMapper on BookingModel {
  BookingEntity get toEntity => BookingEntity(
        id: id,
        userId: userId,
        sessionId: sessionId,
        sessionType: sessionType,
        sessionStartTime: sessionStartTime,
        sessionEndTime: sessionEndTime,
        bookingDate: bookingDate,
        status: status,
      );
}
