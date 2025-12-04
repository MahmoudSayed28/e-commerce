import 'dart:io';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/core/models/review_model.dart';

class ProductModel {
  final String name;
  final String code;
  final String description;
  final num price;
  final File? image; // ✅ خليه nullable علشان مش هيجي من JSON
  final bool isSpecial;
  String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numberOfCalories;
  int sellingCount;
  final num avgRating;
  final num ratingCount;
  final int unitAmount;
  final List<ReviewModel> reviews;

  ProductModel({
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    this.image,
    required this.isSpecial,
    this.sellingCount = 0,
    this.imageUrl,
    required this.expirationsMonths,
    required this.isOrganic,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.reviews,
    this.avgRating = 0,
    this.ratingCount = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      isSpecial: json['isFeatured'] ?? false,
      sellingCount: json['sellingCount'] ?? 0,
      imageUrl: json['imageUrl'],
      expirationsMonths: json['expirationsMonths'] ?? 0,
      isOrganic: json['isOrganic'] ?? false,
      numberOfCalories: json['numberOfCalories'] ?? 0,
      unitAmount: json['unitAmount'] ?? 0,
      avgRating: json['avgRating'] ?? 0,
      ratingCount: json['ratingCount'] ?? 0,
      reviews:
          (json['reviews'] as List<dynamic>? ?? [])
              .map((e) => ReviewModel.fromJson(e))
              .toList(),
    );
  }
  ProductEntity toEntity() {
    return ProductEntity(
      name: name,
      code: code,
      description: description,
      price: price,
      reviews: reviews.map((e) => e.toEntity()).toList(),
      expirationsMonths: expirationsMonths,
      numberOfCalories: numberOfCalories,
      unitAmount: unitAmount,
      isOrganic: isOrganic,
      isSpecial: isSpecial,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'sellingCount': sellingCount,
      'description': description,
      'price': price,
      'isFeatured': isSpecial,
      'imageUrl': imageUrl,
      'expirationsMonths': expirationsMonths,
      'isOrganic': isOrganic,
      'numberOfCalories': numberOfCalories,
      'unitAmount': unitAmount,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}
//? https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg

List<ProductModel> fruitsProducts = [
  ProductModel(
    name: "تفاح أحمر",
    code: "APPLE_RED_001",
    description: "تفاح أحمر طازج، مقرمش وحلو الطعم، مناسب للأكل والعصير.",
    price: 45,
    image: null,
    isSpecial: true,
    imageUrl:
        "https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg",
    expirationsMonths: 2,
    isOrganic: true,
    numberOfCalories: 52,
    unitAmount: 1,
    reviews: [],
  ),

  ProductModel(
    name: "موز بلدي",
    code: "BANANA_002",
    description: "موز بلدي ناضج، غني بالبوتاسيوم ومثالي للطاقة السريعة.",
    price: 30,
    image: null,
    isSpecial: false,
    imageUrl:
        "https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg",
    expirationsMonths: 1,
    isOrganic: false,
    numberOfCalories: 89,
    unitAmount: 1,
    reviews: [],
  ),

  ProductModel(
    name: "فراولة طازجة",
    code: "STRAWBERRY_003",
    description: "فراولة حمراء حلوة، مثالية للعصائر والحلويات.",
    price: 60,
    image: null,
    isSpecial: true,
    imageUrl:
        "https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg",
    expirationsMonths: 1,
    isOrganic: true,
    numberOfCalories: 33,
    unitAmount: 1,
    reviews: [],
  ),

  ProductModel(
    name: "عنب أحمر",
    code: "GRAPE_RED_004",
    description: "عنب أحمر طازج، حلو ولذيذ، مناسب للوجبات الخفيفة.",
    price: 70,
    image: null,
    isSpecial: false,
    imageUrl:
        "https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg",
    expirationsMonths: 1,
    isOrganic: false,
    numberOfCalories: 69,
    unitAmount: 1,
    reviews: [],
  ),

  ProductModel(
    name: "برتقال عصير",
    code: "ORANGE_JUICE_005",
    description: "برتقال ممتاز للعصير، غني بفيتامين سي.",
    price: 35,
    image: null,
    isSpecial: true,
    imageUrl:
        "https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg",
    expirationsMonths: 3,
    isOrganic: true,
    numberOfCalories: 47,
    unitAmount: 1,
    reviews: [],
  ),

  ProductModel(
    name: "مانجا عويسي",
    code: "MANGO_AWESY_006",
    description: "مانجا مصرية من نوع عويسي، طعم ورائحة مميزة.",
    price: 85,
    image: null,
    isSpecial: true,
    imageUrl:
        "https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg",
    expirationsMonths: 1,
    isOrganic: true,
    numberOfCalories: 60,
    unitAmount: 1,
    reviews: [],
  ),

  ProductModel(
    name: "رمان بلدي",
    code: "POMEGRANATE_007",
    description: "رمان بلدي مليان حبوب، مناسب للعصير والأكل.",
    price: 55,
    image: null,
    isSpecial: false,
    imageUrl:
        "https://uvqdcqercosnpmxfdziu.supabase.co/storage/v1/object/public/news/images/images.jpg",
    expirationsMonths: 2,
    isOrganic: false,
    numberOfCalories: 72,
    unitAmount: 1,
    reviews: [],
  ),
];
