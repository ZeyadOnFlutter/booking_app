import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../repository/session_repository.dart';

@lazySingleton
class DeleteBookingUseCase {
  final SessionRepository _sessionRepository;

  const DeleteBookingUseCase(this._sessionRepository);

  Future<Either<Failure, Unit>> call(String bookingId, String sessionId) =>
      _sessionRepository.deleteBooking(bookingId, sessionId);
}
