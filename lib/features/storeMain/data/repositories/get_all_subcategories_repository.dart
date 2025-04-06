import 'package:estore_client/features/storeMain/data/datasource/get_all_subcategories_remote_datasource.dart';
import 'package:estore_client/features/storeMain/domain/entites/get_all_subcategories.dart';
import 'package:estore_client/features/storeMain/domain/repositories/get_all_subcategories_base_repository.dart';

class GetAllSubcategoriesRepository extends GetAllCategoriesBaseRepository {
  final BaseGetAllSubCategoriesRemoteDataSource
  baseGetAllSubCategoriesRemoteDataSource;
  GetAllSubcategoriesRepository(this.baseGetAllSubCategoriesRemoteDataSource);
  @override
  Future<List<GetAllSubCategories>> getAllSubCategories() async {
    return await baseGetAllSubCategoriesRemoteDataSource.getSubCategories();
  }
}
