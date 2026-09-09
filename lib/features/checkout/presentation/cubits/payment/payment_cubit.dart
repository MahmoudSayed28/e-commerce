import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/domain/repos/paymob_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  final PaymobRepo paymentRepo;

  Future<void> createPayment({required OrderEntity order}) async {
    emit(PaymentLoading());

    final result = await paymentRepo.getPaymentKey(
      order: order,
    );

    result.fold(
      (failure) => emit(PaymentFailure(failure.errorMessage)),
      (paymentKey) => emit(PaymentSuccess(paymentKey)),
    );
  }
}
