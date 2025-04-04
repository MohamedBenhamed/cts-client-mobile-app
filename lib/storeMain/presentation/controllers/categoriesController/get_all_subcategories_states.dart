import 'package:estore_client/storeMain/domain/entites/get_all_subcategories.dart';

abstract class SubcategoryState {}

class SubcategoryInitial extends SubcategoryState {}

class SubcategoryLoading extends SubcategoryState {}

class SubcategoryLoaded extends SubcategoryState {
  final List<GetAllSubCategories> subcategories;
  SubcategoryLoaded(this.subcategories);
}

class SubcategoryError extends SubcategoryState {
  final String message;
  SubcategoryError(this.message);
}
