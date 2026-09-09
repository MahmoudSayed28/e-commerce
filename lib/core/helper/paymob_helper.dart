import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/features/checkout/data/models/order_model.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymobService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> getPaymentKey({required OrderEntity order}) async {
    final orderJson = OrderModel.fromEntity(order).toJson();

    final response = await _supabase.functions.invoke(
      'create-paymob-payment',
      body: {
        "amount": (order.cartItemList.calculateTotalPrice() + 30).round(),
        "currency": "EGP",

        "firstName": order.shippingEntity.name,
        "lastName": ".",
        "email": order.shippingEntity.email,
        "phone": order.shippingEntity.phone,

        // هيترسل مع الـ Payment Key
        "order": orderJson,
      },
    );

    final data = response.data;

    if (data == null) {
      throw CustomException('No response from server');
    }

    if (data['success'] != true) {
      throw CustomException(data['message'] ?? 'Something went wrong');
    }

    return data['paymentKey'] as String;
  }
}
