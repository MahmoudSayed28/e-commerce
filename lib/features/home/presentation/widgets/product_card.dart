import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/generated/l10n.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CachedNetworkImage(
                  imageUrl: product.imageUrl ?? '',
                  placeholder:
                      (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Flexible(
                  child: ListTile(
                    title: Text(
                      product.name,
                      style: AppSTextStyles.bold13(null),
                      overflow: TextOverflow.ellipsis, // مهم لو النص طويل
                    ),
                    subtitle: Text(
                      "${product.price} ${S.of(context).pricePerKilo(0)}",
                      style: AppSTextStyles.bold13(AppColors.secondaryColor),
                    ),
                    trailing: GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // زر الإضافة
        ],
      ),
    );
  }
}

class ProductGradView extends StatelessWidget {
  const ProductGradView({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.76,
      ),
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}
