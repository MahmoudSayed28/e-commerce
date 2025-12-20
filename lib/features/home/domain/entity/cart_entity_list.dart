import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';

class CartEntityList {
  final List<CartEntity> cartItems;

  const CartEntityList({required this.cartItems});

  bool isExist(ProductEntity product) {
    return cartItems.any((item) => item.product == product);
  }

  CartEntity? findItem(ProductEntity product) {
    try {
      return cartItems.firstWhere((item) => item.product == product);
    } catch (_) {
      return null;
    }
  }

  CartEntityList addItem(CartEntity item) {
    return CartEntityList(cartItems: [...cartItems, item]);
  }

  CartEntityList updateItem(CartEntity updated) {
    return CartEntityList(
      cartItems:
          cartItems.map((item) {
            return item.product == updated.product ? updated : item;
          }).toList(),
    );
  }

  CartEntityList removeItem(ProductEntity product) {
    return CartEntityList(
      cartItems: cartItems.where((item) => item.product != product).toList(),
    );
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item.totalPrice;
    }
    return totalPrice;
  }
}
