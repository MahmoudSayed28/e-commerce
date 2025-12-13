import 'package:equatable/equatable.dart';
import 'package:fruits_app/core/entities/product_entity.dart';

class CartEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartEntity({required this.product, this.quantity = 1});

  num get totalPrice => product.price * quantity;
  num get totalWeight => product.unitAmount * quantity;

  CartEntity incrementQuantity() {
    return CartEntity(product: product, quantity: quantity + 1);
  }

  CartEntity decrementQuantity() {
    return CartEntity(
      product: product,
      quantity: quantity > 1 ? quantity - 1 : quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
