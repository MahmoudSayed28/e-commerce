import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';

abstract class AddOrderRepo {
  Future<void> addOrder(OrderEntity orderEntity);
}