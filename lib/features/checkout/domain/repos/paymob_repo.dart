import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';

abstract class PaymobRepo {
  Future<Either<Failure, String>> createPayment({
    required String orderId,
  });
}