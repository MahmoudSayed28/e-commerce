import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity userEntity;

  AuthSuccess({required this.userEntity});
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}

class AuthLoading extends AuthState {}
