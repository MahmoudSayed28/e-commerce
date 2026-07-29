import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/helper/firestore_service.dart';
import 'package:fruits_app/core/utils/backend_endpoints.dart';
import 'package:fruits_app/features/checkout/data/models/order_model.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/domain/repos/add_oreder_repo.dart';

class AddOrderRepoImpl extends AddOrderRepo {
  final RemoteDataService remoteDataService;

  AddOrderRepoImpl({required this.remoteDataService});
  @override
  Future<Either<Failure, Unit>> addOrder(OrderEntity orderEntity) async {
   OrderModel orederModel = OrderModel.fromEntity(orderEntity);
  try {
  await  remoteDataService.addData(
      path: BackendEndpoints.oredersPath,
      data: orederModel.toJson(),
    );

    return const Right(unit);
} catch  (e) {
       return Left(ServerFailure(errorMessage:  e.toString()));

}
  }
}
