import 'package:fruits_app/core/helper/firebase_auth_service.dart';
import 'package:fruits_app/core/helper/firestore_service.dart';
import 'package:fruits_app/core/helper/paymob_helper.dart';
import 'package:fruits_app/core/repos/product_repo.dart';
import 'package:fruits_app/core/repos/product_repo_impl.dart';
import 'package:fruits_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_app/features/auth/domain/useCases/auth_use_case.dart';
import 'package:fruits_app/features/checkout/data/repos/add_order_repo_impl.dart';
import 'package:fruits_app/features/checkout/data/repos/paymob_repo_impl.dart';
import 'package:fruits_app/features/checkout/domain/repos/add_oreder_repo.dart';
import 'package:fruits_app/features/checkout/domain/repos/paymob_repo.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void initServiceLocator() {
  getIt.registerSingleton<AuthUseCase>(
    AuthUseCase(
      AuthRepoImpl(
        authService: FirebaseAuthService(),
        remoteDataService: FirestoreService(),
      ),
    ),
  );
  getIt.registerSingleton<ProductRepo>(ProductRepoImpl(FirestoreService()));
  getIt.registerSingleton<AddOrderRepo>(
  AddOrderRepoImpl(
    remoteDataService: FirestoreService(),
  ),
);
   getIt.registerSingleton<PaymobRepo>(
    PaymobRepoImpl(
       paymobService: PaymobService(),
    ),
  );
}
