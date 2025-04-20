import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';

class AuthUseCase {
  final AuthRepo authRepo;

  AuthUseCase(this.authRepo);

  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    return await authRepo.createWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
  }

  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    return await authRepo.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    return await authRepo.loginWithGoogle();
  }
}
