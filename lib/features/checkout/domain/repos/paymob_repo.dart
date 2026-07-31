import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';

abstract class PaymobRepo {
  Future<Either<Failure, String>> getPaymentKey({
    required int amount,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  });
}
