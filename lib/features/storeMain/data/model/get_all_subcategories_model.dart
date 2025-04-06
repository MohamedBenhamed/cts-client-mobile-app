import 'package:estore_client/features/storeMain/domain/entites/get_all_subcategories.dart';

class SubcategoryModel extends GetAllSubCategories {
  const SubcategoryModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.specsKey,
    required super.categoryId,
    required super.iconUrl,
  });

  /// Convert JSON to Model
  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      specsKey: List<String>.from(json['specsKey']),
      categoryId: json['category'],
      iconUrl: json['icon_url'],
    );
  }
}
