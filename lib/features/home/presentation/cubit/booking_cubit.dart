import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/use_case/add_booking_use_case.dart';
import '../../domain/use_case/delete_booking_use_case.dart';
import '../../domain/use_case/get_booking_use_case.dart';
import '../../domain/use_case/update_booking_use_case.dart';
import 'booking_state.dart';

@lazySingleton
class BookingCubit extends Cubit<BookingState> {
  BookingCubit(
    this._addBookingUseCase,
    this._getBookingUseCase,
    this._deleteBookingUseCase,
    this._updateBookingUseCase,
  ) : super(BookingInitial());

  final AddBookingUseCase _addBookingUseCase;
  final DeleteBookingUseCase _deleteBookingUseCase;
  final UpdateBookingUseCase _updateBookingUseCase;
  final GetBookingUseCase _getBookingUseCase;
  List<BookingEntity>? userBookings;

  Future<void> getBookings(String userId) async {
    final response = await _getBookingUseCase(userId);
    response.fold(
      (failure) => emit(GetBookingError(failure.message)),
      (bookings) {
        userBookings = bookings;
        emit(GetBookingSuccess(bookings));
      },
    );
  }

  Future<void> addBooking(BookingEntity booking, String sessionId) async {
    emit(AddBookingLoading());
    final response = await _addBookingUseCase(booking, sessionId);
    response.fold(
      (failure) => emit(AddBookingError(failure.message)),
      (unit) async {
        emit(AddBookingSuccess('Booking Added Successfully'));
        await getBookings(booking.userId);
      },
    );
  }

  Future<void> deleteBooking(String bookingId, String sessionId, String userId) async {
    emit(DeleteBookingLoading());
    final response = await _deleteBookingUseCase(bookingId, sessionId);
    response.fold(
      (failure) => emit(DeleteBookingError(failure.message)),
      (unit) async {
        emit(DeleteBookingSuccess('Booking Deleted Successfully'));
        await getBookings(userId);
      },
    );
  }

  Future<void> updateBooking(BookingEntity bookingEntity, String userId) async {
    emit(UpdateBookingLoading());
    final response = await _updateBookingUseCase(bookingEntity);
    response.fold(
      (failure) => emit(UpdateBookingError(failure.message)),
      (unit) async {
        emit(UpdateBookingSuccess('Booking Deleted Successfully'));
        await getBookings(userId);
      },
    );
  }

  BookingEntity? getBookingForSession(String sessionId) {
    if (userBookings == null) return null;
    try {
      return userBookings!.firstWhere(
        (booking) => booking.sessionId == sessionId,
      );
    } catch (e) {
      return null;
    }
  }
}
