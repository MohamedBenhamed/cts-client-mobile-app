import 'package:estore_client/features/search/domain/entites/productsHeader.dart';

abstract class GetAllProductsBaseRepository {
  Future<List<Productsheader>> getAllProducts();
}
