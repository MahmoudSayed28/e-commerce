import 'package:bloc/bloc.dart';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/core/repos/product_repo.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepo) : super(ProductInitial());
  final ProductRepo productRepo;

  Future<void> getProducts() async {
    emit(ProductLoading());
    final result = await productRepo.getProducts();
    result.fold(
      (failure) => emit(ProductFailure(failure.errorMessage)),
      (products) => emit(ProductSuccess(products)),
    );
  }

  Future<void> getBestSellerProducts() async {
    emit(ProductLoading());
    final result = await productRepo.getBestSellerProducts();
    result.fold(
      (failure) => emit(ProductFailure(failure.errorMessage)),
      (products) => emit(ProductSuccess(products)),
    );
  }
}
