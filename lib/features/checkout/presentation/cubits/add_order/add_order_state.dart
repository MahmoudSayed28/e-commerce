part of 'add_order_cubit.dart';

abstract class AddOrderState {}

class AddOrderInitial extends AddOrderState {}

class AddOrderLoading extends AddOrderState {}

class AddOrderSuccess extends AddOrderState {
  final String orderId;

  AddOrderSuccess({
    required this.orderId,
  });
}
class CardOrderDraftSuccess extends AddOrderState {
  final String orderId;

  CardOrderDraftSuccess({
    required this.orderId,
  });
}

class AddOrderFailure extends AddOrderState {
  final String errorMessage;

  AddOrderFailure({
    required this.errorMessage,
  });
}