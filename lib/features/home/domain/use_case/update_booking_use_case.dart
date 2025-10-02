import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/booking_entity.dart';
import '../repository/session_repository.dart';

@lazySingleton
class UpdateBookingUseCase {
  final SessionRepository _sessionRepository;

  const UpdateBookingUseCase(this._sessionRepository);

  Future<Either<Failure, Unit>> call(BookingEntity bookingEntity) =>
      _sessionRepository.updateBooking(bookingEntity);
}
