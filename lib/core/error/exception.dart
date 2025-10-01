class BookingAppException implements Exception {
  final String message;
  const BookingAppException(this.message);
}

class RemoteException extends BookingAppException {
  const RemoteException(super.message);
  @override
  String toString() => message;
}

class LocalException extends BookingAppException {
  const LocalException(super.message);
}
