import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:fruits_app/core/helper/dummy_product.dart';

import 'package:fruits_app/features/home/presentation/widgets/best_seller_header.dart';
import 'package:fruits_app/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:fruits_app/features/home/presentation/widgets/featured_list.dart';
import 'package:fruits_app/features/home/presentation/widgets/home_search_textfield.dart';
import 'package:fruits_app/features/home/presentation/widgets/product_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  @override
  void initState() {
    context.read<ProductCubit>().getBestSellerProducts();
    super.initState();
    _scrollController =
        ScrollController()..addListener(() {
          if (_scrollController.hasClients) {
            bool isScrolledNow =
                _scrollController.offset >
                MediaQuery.of(context).size.height / 2.9;
            if (isScrolledNow != _isScrolled) {
              setState(() {
                _isScrolled = isScrolledNow;
              });
            }
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CustomHomeAppbar(isScrolled: _isScrolled),
          const SliverToBoxAdapter(child: HomeSearchTextfield()),
          const SliverToBoxAdapter(child: FeaturedList()),
          const SliverToBoxAdapter(child: BestSellerHeader()),
          const BestSellsrProductBuilder(),
        ],
      ),
    );
  }
}

class BestSellsrProductBuilder extends StatelessWidget {
  const BestSellsrProductBuilder({super.key});

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
