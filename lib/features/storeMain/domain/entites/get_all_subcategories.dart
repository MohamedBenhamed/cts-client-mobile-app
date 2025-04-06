import 'package:equatable/equatable.dart';

class GetAllSubCategories extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final List<String> specsKey;
  final int categoryId;
  final String iconUrl;

  const GetAllSubCategories({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.specsKey,
    required this.categoryId,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [
    id,
    nameEn,
    nameAr,
    specsKey,
    categoryId,
    iconUrl,
  ];
}
