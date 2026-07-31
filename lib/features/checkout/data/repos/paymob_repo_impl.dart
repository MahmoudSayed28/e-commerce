import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/helper/paymob_helper.dart';
import 'package:fruits_app/features/checkout/domain/repos/paymob_repo.dart';



class PaymentRepoImpl implements PaymobRepo {
  final PaymobService paymobService;

  PaymentRepoImpl(this.paymobService);

  @override
  Future<Either<Failure, String>> getPaymentKey({
    required int amount,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    try {
      final paymentKey = await paymobService.getPaymentKey(
        amount: amount,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );

      return Right(paymentKey);
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