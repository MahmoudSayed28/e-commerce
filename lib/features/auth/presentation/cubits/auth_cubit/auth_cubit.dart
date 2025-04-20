import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/features/auth/domain/useCases/auth_use_case.dart';
import 'package:fruits_app/features/auth/presentation/cubits/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authUseCase) : super(AuthInitial());
  final AuthUseCase authUseCase;
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    final result = await authUseCase.register(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (ifLeft) => emit(AuthFailure(errorMessage: ifLeft.errorMessage)),
      (ifRight) => emit(AuthSuccess(userEntity: ifRight)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authUseCase.login(email: email, password: password);
    result.fold(
      (ifLeft) => emit(AuthFailure(errorMessage: ifLeft.errorMessage)),
      (ifRight) => emit(AuthSuccess(userEntity: ifRight)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    final result = await authUseCase.loginWithGoogle();
    result.fold(
      (ifLeft) => emit(AuthFailure(errorMessage: ifLeft.errorMessage)),
      (ifRight) => emit(AuthSuccess(userEntity: ifRight)),
    );
  }
}
