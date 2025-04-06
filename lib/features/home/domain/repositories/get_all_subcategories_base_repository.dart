import 'package:estore_client/features/home/domain/entites/get_all_subcategories.dart';

abstract class GetAllCategoriesBaseRepository {
  Future<List<GetAllSubCategories>> getAllSubCategories();
}
