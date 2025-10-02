import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/firebase_error_handler.dart';
import '../../model/booking.dart';
import '../../model/sessions.dart';
import 'firebase_sessions_data_source.dart';

@LazySingleton(as: FirebaseSessionsDataSource)
class FirebaseSessionsDataSourceImpl implements FirebaseSessionsDataSource {
  final FirebaseFirestore _firestore;

  FirebaseSessionsDataSourceImpl(this._firestore);
  @override
  CollectionReference<SessionModel> getSessionCollection() {
    return _firestore.collection('sessions').withConverter(
          fromFirestore: (snapshot, options) => SessionModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  @override
  CollectionReference<BookingModel> getSessionBookingCollection() {
    return _firestore.collection('bookings').withConverter(
          fromFirestore: (snapshot, options) => BookingModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  @override
  Future<List<SessionModel>> getSessionFromFireStore() async {
    try {
      final CollectionReference<SessionModel> sessionCollection = getSessionCollection();
      final QuerySnapshot<SessionModel> querySnapshot = await sessionCollection.get();
      return querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirestoreError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<BookingModel>> getSessionBookingFromFireStore(String userId) async {
    try {
      final CollectionReference<BookingModel> bookingCollection = getSessionBookingCollection();
      final QuerySnapshot<BookingModel> querySnapshot = await bookingCollection
          .where('userId', isEqualTo: userId)
          .orderBy('sessionStartTime', descending: false)
          .get();
      return querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirestoreError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addBookingToFireStore(BookingModel bookingModel, String sessionId) async {
    try {
      final CollectionReference<BookingModel> bookingCollection = getSessionBookingCollection();
      final DocumentReference<BookingModel> docRef = bookingCollection.doc();
      bookingModel.id = docRef.id;
      await docRef.set(bookingModel);
      await _firestore
          .collection('sessions')
          .doc(sessionId)
          .update({'capacity': FieldValue.increment(-1)});
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirestoreError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteBookingFromFireStore(String bookingId, String sessionId) async {
    try {
      final CollectionReference<BookingModel> bookingCollection = getSessionBookingCollection();
      await bookingCollection.doc(bookingId).delete();
      await _firestore
          .collection('sessions')
          .doc(sessionId)
          .update({'capacity': FieldValue.increment(1)});
    } on FirebaseException catch (e) {
      throw FirebaseErrorHandler.handleFirestoreError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
