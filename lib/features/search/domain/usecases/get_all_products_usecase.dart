import 'package:estore_client/features/search/domain/entites/productsHeader.dart';
import 'package:estore_client/features/search/domain/repositories/get_all_products_base_repository.dart';

class GetAllProductsUsecase {
  final GetAllProductsBaseRepository getAllProductsBaseRepository;
  GetAllProductsUsecase(this.getAllProductsBaseRepository);

  Future<List<Productsheader>> call() async {
    return await getAllProductsBaseRepository.getAllProducts();
  }
}
