import 'package:bloc/bloc.dart';
import 'package:fruits_app/features/checkout/domain/repos/paymob_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  final PaymobRepo paymentRepo;

  Future<void> createPayment({
    required String orderId,
  }) async {
    emit(PaymentLoading());

    final result = await paymentRepo.createPayment(
      orderId: orderId,
    );

    result.fold(
      (failure) => emit(
        PaymentFailure(failure.errorMessage),
      ),
      (paymentUrl) => emit(
        PaymentSuccess(paymentUrl),
      ),
    );
  }
}
