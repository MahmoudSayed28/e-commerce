import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';

abstract class AddOrderRepo {
  Future<Either<Failure, String>> addCashOrder({
    required OrderEntity order,
  });

  Future<Either<Failure, String>> createCardOrderDraft({
    required OrderEntity order,
  });
}