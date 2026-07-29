import 'package:fruits_app/features/checkout/data/models/product_order_model.dart';
import 'package:fruits_app/features/checkout/data/models/shipping_model.dart';

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
