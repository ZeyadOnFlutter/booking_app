import '../../domain/entities/booking_entity.dart';
import '../model/booking.dart';

extension BookingMapperToModel on BookingEntity {
  BookingModel get toModel => BookingModel(
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
