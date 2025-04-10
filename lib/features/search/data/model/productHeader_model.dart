import 'package:estore_client/features/search/domain/entites/productsHeader.dart';

class ProductheaderModel extends Productsheader {
  const ProductheaderModel({
    required super.id,
    required super.name,
    required super.price,
    required super.discount,
    required super.description,
    required super.specs,
    required super.images,
    required super.stock,
    required super.brandName,
    required super.brandId,
    required super.brandIcon,
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
      description: json['description'],
      images: List<String>.from(json['images']),
      specs: Map<String, String>.from(json['specs']),
      stock: json['stock'],
      brandName: json['brand']['name'],
      brandId: json['brand']['id'],
      brandIcon: json['brand']['icon_url'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
