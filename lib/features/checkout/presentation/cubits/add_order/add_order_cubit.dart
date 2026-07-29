import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/domain/repos/add_oreder_repo.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit({required this.addOrederRepo}) : super(AddOrderInitial());
  final AddOrderRepo addOrederRepo;
  void addOrder({required OrderEntity order}) async {
    emit(AddOrderLoading());
    final result = await addOrederRepo.addOrder( order);
    result.fold(
      (failure) => emit(AddOrderFailure(errorMessage: failure.errorMessage)),
      (success) => emit(AddOrderSuccess()),
    );
  }
}
