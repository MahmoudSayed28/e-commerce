import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymobService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> getPaymentKey({
    required double price,
    required String firstName,
    required String email,
    required String phone,
  }) async {
    final response = await _supabase.functions.invoke(
      'create-paymob-payment',
      body: {
        "amount": price,
        "currency": "EGP",
        "firstName": firstName,
        "email": email,
        "phone": phone,
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
