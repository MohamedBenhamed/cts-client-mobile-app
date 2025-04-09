import 'package:equatable/equatable.dart';

class Productsheader extends Equatable {
  final int id;
  final String name;
  final String price;
  final String discount;
  final List<String> images;
  final int stock;
  final String brandName;
  final int brandId;
  final int categoryId;
  final int subcategoryId;
  final DateTime createdAt;

  const Productsheader({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.images,
    required this.stock,
    required this.brandName,
    required this.brandId,
    required this.categoryId,
    required this.subcategoryId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    discount,
    images,
    stock,
    brandName,
    brandId,
    categoryId,
    subcategoryId,
    createdAt,
  ];
}
