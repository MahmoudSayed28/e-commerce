import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:fruits_app/core/helper/service_locator.dart';
import 'package:fruits_app/core/repos/product_repo.dart';
import 'package:fruits_app/features/home/presentation/widgets/products_view_body.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});
  static const String id = 'productView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(getIt.get<ProductRepo>()),
      child: const Scaffold(body: SafeArea(child: ProductsViewBody())),
    );
  }
}
