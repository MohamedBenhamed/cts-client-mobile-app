import 'package:estore_client/features/search/data/datasource/get_all_productsHeaders_remote_datasource.dart';
import 'package:estore_client/features/search/domain/entites/productsHeader.dart';
import 'package:estore_client/features/search/domain/repositories/get_all_products_base_repository.dart';

class GetAllProductsRepository extends GetAllProductsBaseRepository {
  final BaseGetAllProductsHeadersRemoteDataSource
  baseGetAllProductsHeadersRemoteDataSource;
  GetAllProductsRepository(this.baseGetAllProductsHeadersRemoteDataSource);

  @override
  Future<List<Productsheader>> getAllProducts() {
    return baseGetAllProductsHeadersRemoteDataSource.getProductsHeaders();
  }
}
