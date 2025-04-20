import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/helper/firebase_auth_service.dart';
import 'package:fruits_app/core/helper/firestore_service.dart';
import 'package:fruits_app/core/utils/backend_endpoints.dart';
import 'package:fruits_app/features/auth/data/models/user_model.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService authService;
  final RemoteDataService remoteDataService;

  AuthRepoImpl({required this.authService, required this.remoteDataService});

  @override
  Future<Either<Failure, UserEntity>> createWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    User? user;
    try {
      user = await authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserEntity userEntity = UserModel(
        email: email,
        name: name,
        uId: user.uid,
      );
      log(
        'email: ${userEntity.email} name: ${userEntity.name} uId: ${userEntity.uId}',
      );
      await addUser(userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      user != null ? await authService.deleteUser() : null;
      return left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      log(e.toString());
      user != null ? await authService.deleteUser() : null;

      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await authService.login(email: email, password: password);
      return right(UserModel.fromFireBase(user));
    } on CustomException catch (e) {
      return left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    User? user;
    try {
      user = await authService.signInWithGoogle();
      var userEntity = UserModel.fromFireBase(user);
      await addUser(userEntity);
      return right(UserModel.fromFireBase(user));
    } catch (e) {
      user != null ? await authService.deleteUser() : null;

      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future addUser(UserEntity user) async {
    return await remoteDataService.addData(
      data: user.toMap(),
      path: BackendEndpoints.path,
    );
  }
}
