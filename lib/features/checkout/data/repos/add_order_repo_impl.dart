import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/helper/firestore_service.dart';
import 'package:fruits_app/features/checkout/data/models/order_model.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/domain/repos/add_oreder_repo.dart';
import 'package:uuid/uuid.dart';

class AddOrderRepoImpl implements AddOrderRepo {
  final RemoteDataService remoteDataService;

  AddOrderRepoImpl({
    required this.remoteDataService,
  });

  final Uuid _uuid = const Uuid();

  @override
  Future<Either<Failure, String>> addCashOrder({
    required OrderEntity order,
  }) async {
    try {
      final orderId = _uuid.v4();

      final subtotal =
          order.cartItemList.calculateTotalPrice().toDouble();

      const shippingCost = 0.0;

      final orderModel = OrderModel.fromEntity(
        entity: order,
        paymentMethod: 'cash',
        paymentStatus: 'pending',
        orderStatus: 'pending',
        subtotal: subtotal,
        shippingCost: shippingCost,
      );

      await remoteDataService.addData(
        path: 'orders',
        documentId: orderId,
        data: {
          ...orderModel.toJson(),
          'orderId': orderId,
        },
      );

      return Right(orderId);
    } catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> createCardOrderDraft({
    required OrderEntity order,
  }) async {
    try {
      final orderId = _uuid.v4();

      final subtotal =
          order.cartItemList.calculateTotalPrice().toDouble();

      const shippingCost = 0.0;

      final orderModel = OrderModel.fromEntity(
        entity: order,
        paymentMethod: 'card',
        paymentStatus: 'awaiting_payment',
        orderStatus: 'awaiting_payment',
        subtotal: subtotal,
        shippingCost: shippingCost,
      );

      await remoteDataService.addData(
        path: 'orders',
        documentId: orderId,
        data: {
          ...orderModel.toJson(),
          'orderId': orderId,
        },
      );

      return Right(orderId);
    } catch (e) {
      return Left(
       ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}