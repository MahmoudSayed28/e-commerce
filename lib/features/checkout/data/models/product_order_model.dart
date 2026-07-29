import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';

class ProductOrderModel {
  final String name;
  final String code;
  final String imageUrl;
  final double price;
  final int quantity;

  ProductOrderModel({
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
  factory ProductOrderModel.fromEntity(CartEntity entity) {
    return ProductOrderModel(
      name: entity.product.name,
      code: entity.product.code,
      imageUrl: entity.product.imageUrl ?? "",
      price: entity.product.price.toDouble(),
      quantity: entity.quantity,
    );
  }
  toJson() {
    return {
      'name': name,
      'code': code,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}
