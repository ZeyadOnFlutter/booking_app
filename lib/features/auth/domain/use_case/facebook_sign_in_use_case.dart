import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class FacebookSignInUseCase {
  final AuthRepository _authRepository;

  FacebookSignInUseCase(this._authRepository);

  Future<Either<Failure, UserEntity>> call() => _authRepository.signInWithFacebook();
}
