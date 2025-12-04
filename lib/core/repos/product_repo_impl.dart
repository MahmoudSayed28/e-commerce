import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/helper/firestore_service.dart';
import 'package:fruits_app/core/models/product_model.dart';
import 'package:fruits_app/core/repos/product_repo.dart';
import 'package:fruits_app/core/utils/constant.dart';

class ProductRepoImpl implements ProductRepo {
  final RemoteDataService remoteDataService;

  ProductRepoImpl(this.remoteDataService);
  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellerProducts() async {
    try {
      var data =
          await remoteDataService.getData(
                path: kProducts,
                query: {
                  'orderBy': 'sellingCount',
                  'limit': 10,
                  'descending': true,
                },
              )
              as List<Map<String, dynamic>>;
      List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();
      List<ProductEntity> productEntities =
          products.map((e) => e.toEntity()).toList();
      log(productEntities.toString());

      return right(productEntities);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: 'Failed to get products $e'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var data =
          await remoteDataService.getData(path: kProducts)
              as List<Map<String, dynamic>>;
      List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();
      List<ProductEntity> productEntities =
          products.map((e) => e.toEntity()).toList();
      log(productEntities.toString());
      return right(productEntities);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: 'Failed to get products $e'));
    }
  }
}
