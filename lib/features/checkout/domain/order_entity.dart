import 'package:fruits_app/features/checkout/domain/shipping_entity.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity_list.dart';

class OrderEntity {
  final CartEntityList cartItemList;
  final ShippingEntity? shippingEntity;
  bool? payWithCash;

  OrderEntity({
    required this.cartItemList,
    this.shippingEntity,
    this.payWithCash,
  });
}
