import 'package:estore_client/features/storeMain/domain/entites/get_all_subcategories.dart';

abstract class GetAllCategoriesBaseRepository {
  Future<List<GetAllSubCategories>> getAllSubCategories();
}
