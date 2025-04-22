import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruits_app/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:fruits_app/features/home/presentation/widgets/featured_item.dart';
import 'package:fruits_app/features/home/presentation/widgets/home_search_textfield.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),

      child: CustomScrollView(
        slivers: [
          CustomHomeAppbar(),
          SliverToBoxAdapter(child: HomeSearchTextfield()),
          SliverToBoxAdapter(child: FeaturedItem()),
        ],
      ),
    );
  }
}
