import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/booking_entity.dart';
import '../entities/session_entity.dart';

abstract class SessionRepository {
  Future<Either<Failure, List<SessionEntity>>> getSessions();
  Future<Either<Failure, List<BookingEntity>>> getSessionBooking(String userId);
  Future<Either<Failure, Unit>> addBooking(BookingEntity bookingEntity, String sessionId);
  Future<Either<Failure, Unit>> deleteBooking(String bookingId, String sessionId);
}
