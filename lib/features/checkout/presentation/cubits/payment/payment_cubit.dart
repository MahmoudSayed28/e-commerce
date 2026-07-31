import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruits_app/features/checkout/domain/repos/paymob_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo)
      : super(PaymentInitial());

  final PaymobRepo paymentRepo;

  Future<void> createPayment({
    required int amount,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(PaymentLoading());

    final result = await paymentRepo.getPaymentKey(
      amount: amount,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );

    result.fold(
      (failure) => emit(
        PaymentFailure(failure.errorMessage),
      ),
      (paymentKey) => emit(
        PaymentSuccess(paymentKey),
      ),
    );
  }
}