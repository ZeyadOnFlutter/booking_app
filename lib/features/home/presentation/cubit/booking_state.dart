import '../../domain/entities/booking_entity.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class AddBookingLoading extends BookingState {}

class AddBookingError extends BookingState {
  final String message;

  AddBookingError(this.message);
}

class AddBookingSuccess extends BookingState {
  final String successMessage;

  AddBookingSuccess(this.successMessage);
}

class DeleteBookingLoading extends BookingState {}

class DeleteBookingError extends BookingState {
  final String message;

  DeleteBookingError(this.message);
}

class DeleteBookingSuccess extends BookingState {
  final String successMessage;

  DeleteBookingSuccess(this.successMessage);
}

class UpdateBookingLoading extends BookingState {}

class UpdateBookingError extends BookingState {
  final String message;

  UpdateBookingError(this.message);
}

class UpdateBookingSuccess extends BookingState {
  final String successMessage;

  UpdateBookingSuccess(this.successMessage);
}

class GetBookingLoading extends BookingState {}

class GetBookingError extends BookingState {
  final String message;

  GetBookingError(this.message);
}

class GetBookingSuccess extends BookingState {
  final List<BookingEntity> bookings;

  GetBookingSuccess(this.bookings);
}
