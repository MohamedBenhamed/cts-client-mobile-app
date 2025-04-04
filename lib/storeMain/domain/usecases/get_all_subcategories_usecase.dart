import 'package:estore_client/storeMain/domain/entites/get_all_subcategories.dart';
import 'package:estore_client/storeMain/domain/repositories/get_all_subcategories_base_repository.dart';

class GetAllSubCategoriesUseCase {
  final GetAllCategoriesBaseRepository getAllCategoriesBaseRepository;

  GetAllSubCategoriesUseCase(this.getAllCategoriesBaseRepository);

  Future<List<GetAllSubCategories>> call() async {
    return await getAllCategoriesBaseRepository.getAllSubCategories();
  }
}
