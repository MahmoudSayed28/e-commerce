part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}
final class PaymentLoading extends PaymentState {}
final class PaymentSuccess extends PaymentState {
  final String paymentKey;

  const PaymentSuccess(this.paymentKey);

  @override
  List<Object> get props => [paymentKey];
}
final class PaymentFailure extends PaymentState {
  final String errorMessage;

  const PaymentFailure( this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}


