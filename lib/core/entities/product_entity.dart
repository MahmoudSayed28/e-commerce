import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fruits_app/core/entities/review_entity.dart';

class ProductEntity extends Equatable {
  final String name;
  final String code;
  final String? imageUrl;
  final File? image;
  final String description;
  final num price;
  final bool isSpecial;
  final int expirationsMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final num avgRating = 0;
  final num ratingCount = 0;
  final int unitAmount;
  final List<ReviewEntity> reviews;
  const ProductEntity({
    required this.name,
    required this.code,
    this.imageUrl,
    this.image,
    required this.description,
    required this.price,
    required this.isSpecial,
    required this.expirationsMonths,
    required this.isOrganic,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.reviews,
  });

  @override
  List<Object?> get props => [code];
}
