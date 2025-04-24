import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:fruits_app/features/home/presentation/widgets/best_seller_header.dart';
import 'package:fruits_app/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:fruits_app/features/home/presentation/widgets/featured_list.dart';
import 'package:fruits_app/features/home/presentation/widgets/home_search_textfield.dart';
import 'package:fruits_app/features/home/presentation/widgets/product_card.dart';

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
          const ProductGradView(),
        ],
      ),
    );
  }
}
