import 'package:estore_client/features/search/domain/entites/productsHeader.dart';

class ProductheaderModel extends Productsheader {
  const ProductheaderModel({
    required super.id,
    required super.name,
    required super.price,
    required super.discount,
    required super.images,
    required super.categoryId,
    required super.subcategoryId,
    required super.createdAt,
  });
  factory ProductheaderModel.fromJson(Map<String, dynamic> json) {
    return ProductheaderModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      discount: json['discount'],
      images: List<String>.from(json['images']),
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
