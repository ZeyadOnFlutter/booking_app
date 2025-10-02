import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/repository/session_repository.dart';
import '../data_source/firebase_data_source/firebase_sessions_data_source.dart';
import '../mapper/booking_mapper.dart';
import '../mapper/booking_mapper_to_model.dart';
import '../mapper/session_mapper.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {
  final FirebaseSessionsDataSource _firebaseSessionsDataSource;

  SessionRepositoryImpl(this._firebaseSessionsDataSource);
  @override
  Future<Either<Failure, List<SessionEntity>>> getSessions() async {
    try {
      final response = await _firebaseSessionsDataSource.getSessionFromFireStore();
      return Right(response.map((session) => session.toEntity).toList());
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addBooking(BookingEntity bookingEntity, String sessionId) async {
    try {
      await _firebaseSessionsDataSource.addBookingToFireStore(bookingEntity.toModel, sessionId);
      return const Right(unit);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getSessionBooking(String userId) async {
    try {
      final response = await _firebaseSessionsDataSource.getSessionBookingFromFireStore(userId);
      return Right(response.map((booking) => booking.toEntity).toList());
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBooking(String bookingId, String sessionId) async {
    try {
      await _firebaseSessionsDataSource.deleteBookingFromFireStore(bookingId, sessionId);
      return const Right(unit);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBooking(BookingEntity bookingEntity) async {
    try {
      await _firebaseSessionsDataSource.updateBookingInFireStore(bookingEntity.toModel);
      return const Right(unit);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
