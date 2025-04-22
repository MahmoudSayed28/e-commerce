import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/widgets/featured_item.dart';

class FeaturedList extends StatelessWidget {
  const FeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.25,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (index) => const FeaturedItem()),
          ),
        ),
      ),
    );
  }
}
