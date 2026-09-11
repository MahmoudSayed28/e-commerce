import 'package:fruits_app/features/checkout/data/models/product_order_model.dart';
import 'package:fruits_app/features/checkout/data/models/shipping_model.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';

class OrderModel {
  final String uId;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;

  final double subtotal;
  final double shippingCost;
  final double totalPrice;

  final ShippingModel shippingModel;
  final List<ProductOrderModel> productOrderList;

  final String? transactionId;
  final String? paymobOrderId;

  OrderModel({
    required this.uId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.subtotal,
    required this.shippingCost,
    required this.totalPrice,
    required this.shippingModel,
    required this.productOrderList,
    this.transactionId,
    this.paymobOrderId,
  });

  factory OrderModel.fromEntity({
    required OrderEntity entity,
    required String paymentMethod,
    required String paymentStatus,
    required String orderStatus,
    required double subtotal,
    required double shippingCost,
  }) {
    return OrderModel(
      uId: entity.uId,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      subtotal: subtotal,
      shippingCost: shippingCost,
      totalPrice: subtotal + shippingCost,
      shippingModel: ShippingModel.fromEntity(
        entity.shippingEntity,
      ),
      productOrderList: entity.cartItemList.cartItems
          .map(
            (item) => ProductOrderModel.fromEntity(item),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'subtotal': subtotal,
      'shippingCost': shippingCost,
      'totalPrice': totalPrice,
      'shipping': shippingModel.toJson(),
      'products': productOrderList
          .map((product) => product.toJson())
          .toList(),
      'payment': {
        'transactionId': transactionId,
        'paymobOrderId': paymobOrderId,
      },
    };
  }
}