import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/booking_entity.dart';
import '../repository/session_repository.dart';

@lazySingleton
class GetBookingUseCase {
  final SessionRepository _sessionRepository;

  const GetBookingUseCase(this._sessionRepository);
  Future<Either<Failure, List<BookingEntity>>> call(String userId) =>
      _sessionRepository.getSessionBooking(userId);
}
