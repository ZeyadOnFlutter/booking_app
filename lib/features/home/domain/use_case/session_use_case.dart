import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/session_entity.dart';
import '../repository/session_repository.dart';

@lazySingleton
class SessionUseCase {
  final SessionRepository _sessionRepository;

  SessionUseCase(this._sessionRepository);

  Future<Either<Failure, List<SessionEntity>>> call() => _sessionRepository.getSessions();
}
