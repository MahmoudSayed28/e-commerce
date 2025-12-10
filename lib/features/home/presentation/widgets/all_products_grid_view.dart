import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:fruits_app/core/helper/dummy_product.dart';
import 'package:fruits_app/features/home/presentation/widgets/product_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllProductsGridView extends StatelessWidget {
  const AllProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          log('success');
          log(state.products.toString());
          return ProductGradView(products: state.products);
        } else if (state is ProductFailure) {
          log('failure');

          return Center(child: Text(state.errorMessage));
        } else {
          log('loading');

          return Skeletonizer.sliver(
            child: ProductGradView(products: getDummyProducts()),
          );
        }
      },
    );
  }
}
