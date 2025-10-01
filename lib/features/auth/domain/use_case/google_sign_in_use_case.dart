import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class GoogleSignInUseCase {
  final AuthRepository _authRepository;

  GoogleSignInUseCase(this._authRepository);

  Future<Either<Failure, UserEntity>> call() => _authRepository.signInWithGoogle();
}
