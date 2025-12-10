import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:fruits_app/core/utils/widgets/custom_home_appbar.dart';
import 'package:fruits_app/features/home/presentation/widgets/all_products_grid_view.dart';
import 'package:fruits_app/features/home/presentation/widgets/home_search_textfield.dart';
import 'package:fruits_app/features/home/presentation/widgets/result_search_row.dart';
import 'package:fruits_app/generated/l10n.dart';

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
