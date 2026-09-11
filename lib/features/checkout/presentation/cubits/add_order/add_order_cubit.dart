import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/domain/repos/add_oreder_repo.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit({
    required this.addOrderRepo,
  }) : super(AddOrderInitial());

  final AddOrderRepo addOrderRepo;

  Future<void> addCashOrder({
    required OrderEntity order,
  }) async {
    emit(AddOrderLoading());

    final result = await addOrderRepo.addCashOrder(
      order: order,
    );

    result.fold(
      (failure) {
        emit(
          AddOrderFailure(
            errorMessage: failure.errorMessage,
          ),
        );
      },
      (orderId) {
        emit(
          AddOrderSuccess(
            orderId: orderId,
          ),
        );
      },
    );
  }

  Future<void> createCardOrderDraft({
    required OrderEntity order,
  }) async {
    emit(AddOrderLoading());

    final result = await addOrderRepo.createCardOrderDraft(
      order: order,
    );

    result.fold(
      (failure) {
        emit(
          AddOrderFailure(
            errorMessage: failure.errorMessage,
          ),
        );
      },
      (orderId) {
        emit(
          AddOrderSuccess(
            orderId: orderId,
          ),
        );
      },
    );
  }
}