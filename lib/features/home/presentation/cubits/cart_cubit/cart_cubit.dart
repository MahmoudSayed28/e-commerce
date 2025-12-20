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
      existingItem.increasCount();
      cartItems = CartEntityList(cartItems: List.from(cartItems.cartItems));
    } else {
      cartItems = cartItems.addItem(CartEntity(product: product, quantity: 1));
    }

    emit(CartItemAdded(cartItems));
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems.cartItems) {
      totalPrice += item.totalPrice;
    }
    return totalPrice;
  }

  void removeCart(CartEntity cart) {
    cartItems = cartItems.removeItem(cart.product);
    emit(CartItemRemoved(cartItems));
  }
}
