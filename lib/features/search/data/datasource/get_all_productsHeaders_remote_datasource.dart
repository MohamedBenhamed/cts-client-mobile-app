import 'package:estore_client/core/network/api_constance.dart';
import 'package:estore_client/core/network/dio_client.dart';
import 'package:estore_client/features/search/data/model/productHeader_model.dart';

abstract class BaseGetAllProductsHeadersRemoteDataSource {
  Future<List<ProductheaderModel>> getProductsHeaders();
}

class GetAllProductsHeadersRemoteDataSource
    implements BaseGetAllProductsHeadersRemoteDataSource {
  final DioClient dioClient;

  GetAllProductsHeadersRemoteDataSource({required this.dioClient});

  @override
  Future<List<ProductheaderModel>> getProductsHeaders() async {
    try {
      final response = await dioClient.get(ApiConstance.getProductsHeaders);

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        return (response.data as List)
            .map((e) => ProductheaderModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to fetch products headers data: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Response data:$e');
      throw Exception('Error fetching products headers data: $e');
    }
  }
}
