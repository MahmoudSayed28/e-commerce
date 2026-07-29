import 'package:fruits_app/features/checkout/data/models/product_order_model.dart';
import 'package:fruits_app/features/checkout/data/models/shipping_model.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';

class OrderModel {
  final String uId;
  final String paymentMethod;
  final double totalPrice;
  final ShippingModel shippingModel;
  final List<ProductOrderModel> productOrderList;

  OrderModel({
    required this.uId,
    required this.paymentMethod,
    required this.totalPrice,
    required this.shippingModel,
    required this.productOrderList,
  });
  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      uId: entity.uId,
      paymentMethod: entity.payWithCash == true ? 'cash' : 'card',
      totalPrice: entity.cartItemList.calculateTotalPrice().toDouble(),
      shippingModel: ShippingModel.fromEntity(entity.shippingEntity),
      productOrderList:
          entity.cartItemList.cartItems
              .map((e) => ProductOrderModel.fromEntity(e))
              .toList(),
    );
  }
  toJson() {
    return {
      'uId': uId,
      'paymentMethod': paymentMethod,
      'totalPrice': totalPrice,
      'shippingModel': shippingModel.toJson(),
      'productOrderList':
          productOrderList.map((product) => product.toJson()).toList(),
    };
  }
}
