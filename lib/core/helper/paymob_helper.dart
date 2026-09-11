import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymobService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> createPayment({
    required String orderId,
  }) async {
    try {
      final response = await _supabase.functions.invoke(
        'create-paymob-payment',
        body: {
          'orderId': orderId,
        },
      );

      final data = response.data;

      if (data == null) {
        throw CustomException(
          'No response from server',
        );
      }

      if (data is! Map) {
        throw CustomException(
          'Invalid response from server',
        );
      }

      if (data['success'] != true) {
        throw CustomException(
          data['message']?.toString() ??
              'Payment creation failed',
        );
      }

      final paymentUrl = data['paymentUrl'];

      if (paymentUrl == null ||
          paymentUrl.toString().isEmpty) {
        throw CustomException(
          'Payment URL was not returned',
        );
      }

      return paymentUrl.toString();
    } on FunctionException catch (e) {
      throw CustomException(
        e.reasonPhrase ?? 'Payment service error',
      );
    } on CustomException {
      rethrow;
    } catch (e) {
      throw CustomException(
        e.toString(),
      );
    }
  }
}