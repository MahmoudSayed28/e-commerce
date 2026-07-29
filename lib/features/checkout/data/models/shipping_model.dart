import 'package:fruits_app/features/checkout/domain/shipping_entity.dart';

class ShippingModel {
  String? name;
  String? phone;
  String? address;
  String? email;
  String? addressDetails;
  String? city;
  ShippingModel({
    this.name,
    this.phone,
    this.address,
    this.email,
    this.addressDetails,
    this.city,
  });

  factory ShippingModel.fromEntity(ShippingEntity entity) {
    return ShippingModel(
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      email: entity.email,
      addressDetails: entity.addressDetails,
      city: entity.city,
    );
  }
  toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'addressDetails': addressDetails,
      'city': city,
    };
  }
}
