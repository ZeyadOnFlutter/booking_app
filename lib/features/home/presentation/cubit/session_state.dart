import '../../domain/entities/session_entity.dart';

abstract class SessionState {}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionError extends SessionState {
  final String errorMessage;

  SessionError(this.errorMessage);
}

class SessionSuccess extends SessionState {
  final List<SessionEntity> sessions;

  SessionSuccess(this.sessions);
}
