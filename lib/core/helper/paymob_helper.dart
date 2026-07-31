import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class PaymobService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> getPaymentKey({
    required int amount,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    final response = await _supabase.functions.invoke(
      'create-paymob-payment',
      body: {
        "amount": amount,
        "currency": "EGP",
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
      },
    );

    final data = response.data;

    if (data == null) {
      throw CustomException('No response from server');
    }

    if (data['success'] != true) {
      throw CustomException(
        data['message'] ?? 'Something went wrong',
      );
    }

    return data['paymentKey'] as String;
  }
}