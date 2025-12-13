import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity_list.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  CartEntityList cartItems = const CartEntityList(cartItems: []);

  void addProductToCart(ProductEntity product) {
    final existingItem = cartItems.findItem(product);

    if (existingItem != null) {
      final updatedItem = existingItem.incrementQuantity();
      cartItems = cartItems.updateItem(updatedItem);
    } else {
      cartItems = cartItems.addItem(CartEntity(product: product, quantity: 1));
    }

    emit(CartUpdated(cartItems));
  }
}
