import 'package:fruits_app/core/entities/product_entity.dart';

class CartEntity {
  final ProductEntity product;
  int quantity;
  CartEntity({required this.product, this.quantity = 1});
  num get totalPrice => product.price * quantity;
  num get totalWeight => product.unitAmount * quantity;
  void incrementQuantity() {
    quantity += 1;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity -= 1;
    }
  }
}
