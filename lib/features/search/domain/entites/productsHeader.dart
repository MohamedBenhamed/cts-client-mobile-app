import 'package:equatable/equatable.dart';

class Productsheader extends Equatable {
  final int id;
  final String name;
  final String price;
  final String description;
  final Map<String, String> specs;
  double get discountedPrice {
    final priceDouble = double.tryParse(
      price.toString(),
    ); // Convert price to double
    final discountDouble = double.tryParse(
      discount,
    ); // Convert discount to double

    if (priceDouble != null && discountDouble != null && discountDouble > 0) {
      return priceDouble * (1 - discountDouble);
    }
    return priceDouble ?? 0.0; // If priceDouble is null, return 0.0
  }

  double get originalPrice {
    final priceDouble = double.tryParse(
      price.toString(),
    ); // Convert price to double
    final discountDouble = double.tryParse(
      discount,
    ); // Convert discount to double

    if (priceDouble != null && discountDouble != null && discountDouble > 0) {
      return priceDouble;
    }
    return 0.0;
  }

  final String discount;
  final List<String> images;
  final int stock;
  bool get isOutOfStock => stock == 0;
  final String brandName;
  final int brandId;
  final String brandIcon;
  final int categoryId;
  final int subcategoryId;
  final DateTime createdAt;

  const Productsheader({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.specs,
    required this.discount,
    required this.images,
    required this.stock,
    required this.brandName,
    required this.brandId,
    required this.brandIcon,
    required this.categoryId,
    required this.subcategoryId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    description,
    specs,
    discount,
    images,
    stock,
    brandName,
    brandId,
    brandIcon,
    categoryId,
    subcategoryId,
    createdAt,
  ];
}
