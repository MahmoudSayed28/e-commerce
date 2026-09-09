import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';

abstract class PaymobRepo {
  Future<Either<Failure, String>> getPaymentKey({
    required OrderEntity order,
  });
}
