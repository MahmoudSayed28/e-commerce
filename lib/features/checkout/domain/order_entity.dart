import 'package:fruits_app/features/checkout/domain/shipping_entity.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';

class OrderEntity {
  final List<CartEntity> cartItems;
  final ShippingEntity shippingEntity;
  final bool payWithCash;

  OrderEntity({
    required this.cartItems,
    required this.shippingEntity,
    required this.payWithCash,
  });
}
