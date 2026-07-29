
import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/domain/shipping_entity.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity_list.dart';

class OrderEntity extends ChangeNotifier {
  final CartEntityList cartItemList;
  ShippingEntity shippingEntity = ShippingEntity();
  bool? payWithCash;
final String uId;
  OrderEntity({required this.cartItemList, this.payWithCash, required this.uId});
}
