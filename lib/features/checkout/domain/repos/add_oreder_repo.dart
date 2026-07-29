import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';

abstract class AddOrderRepo {
  Future<Either<Failure, Unit>> addOrder(OrderEntity orderEntity);
}