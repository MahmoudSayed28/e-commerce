import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/helper/paymob_helper.dart';
import 'package:fruits_app/features/checkout/domain/repos/paymob_repo.dart';

class PaymobRepoImpl implements PaymobRepo {
  final PaymobService paymobService;

  PaymobRepoImpl({
    required this.paymobService,
  });

  @override
  Future<Either<Failure, String>> createPayment({
    required String orderId,
  }) async {
    try {
      final paymentUrl = await paymobService.createPayment(
        orderId: orderId,
      );

      return Right(paymentUrl);
    } on CustomException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}