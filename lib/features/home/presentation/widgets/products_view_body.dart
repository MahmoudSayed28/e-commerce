import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:fruits_app/core/helper/dummy_product.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/core/utils/widgets/custom_home_appbar.dart';
import 'package:fruits_app/features/home/presentation/widgets/home_search_textfield.dart';
import 'package:fruits_app/features/home/presentation/widgets/product_grid_view.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCubit>().getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: customHomeAppBar(S.of(context).products)),
          const SliverToBoxAdapter(child: HomeSearchTextfield()),
          SliverToBoxAdapter(
            child: SearchResultRow(
              resultsCount: context.watch<ProductCubit>().productsLength,
            ),
          ),
          const AllProductsGridView(),
        ],
      ),
    );
  }
}

class SearchResultRow extends StatelessWidget {
  const SearchResultRow({super.key, required this.resultsCount});
  final int resultsCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          " $resultsCount ${S.of(context).results} ",
          style: AppSTextStyles.bold13(null),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.assetsImagesFilter2),
        ),
      ],
    );
  }
}

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
