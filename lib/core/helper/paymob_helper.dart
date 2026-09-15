import 'package:dio/dio.dart';
import 'package:fruits_app/core/errors/exceptions.dart';

class PaymobService {
  final Dio _dio = Dio();

  static const String _baseUrl =
      'https://e-commerce-production-fbf1.up.railway.app';

  Future<String> createPayment({
    required String orderId,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/paymob/create-payment',
        data: {
          'orderId': orderId,
        },
      );

      final data = response.data;

      if (data == null || data is! Map) {
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
    } on DioException catch (e) {
      final message =
          e.response?.data is Map
              ? e.response?.data['message']?.toString()
              : null;

      throw CustomException(
        message ??
            e.message ??
            'Payment service error',
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