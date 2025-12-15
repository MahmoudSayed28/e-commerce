import 'package:bloc/bloc.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';

part 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit() : super(CartItemInitial());
  void cartItemUpdated(CartEntity cartEntity) {
    emit(CartItemUpdated(cartEntity));
  }
}
