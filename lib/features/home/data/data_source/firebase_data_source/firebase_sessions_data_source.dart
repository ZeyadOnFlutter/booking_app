import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/booking.dart';
import '../../model/sessions.dart';

abstract class FirebaseSessionsDataSource {
  CollectionReference<SessionModel> getSessionCollection();
  CollectionReference<BookingModel> getSessionBookingCollection();
  Future<List<SessionModel>> getSessionFromFireStore();
  Future<List<BookingModel>> getSessionBookingFromFireStore(String userId);
  Future<void> addBookingToFireStore(BookingModel bookingModel, String sessionId);
  Future<void> deleteBookingFromFireStore(String bookingId, String sessionId);
  Future<void> updateBookingInFireStore(BookingModel bookingModel);
}
