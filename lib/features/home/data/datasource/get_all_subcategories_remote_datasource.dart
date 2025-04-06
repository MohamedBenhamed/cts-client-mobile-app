import 'package:estore_client/core/network/api_constance.dart';
import 'package:estore_client/core/network/dio_client.dart';
import 'package:estore_client/features/home/data/model/get_all_subcategories_model.dart';

abstract class BaseGetAllSubCategoriesRemoteDataSource {
  Future<List<SubcategoryModel>> getSubCategories();
}

class GetAllSubCategoriesRemoteDataSource
    implements BaseGetAllSubCategoriesRemoteDataSource {
  final DioClient dioClient;

  GetAllSubCategoriesRemoteDataSource({required this.dioClient});

  @override
  Future<List<SubcategoryModel>> getSubCategories() async {
    try {
      final response = await dioClient.get(ApiConstance.getSubCategories);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => SubcategoryModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to fetch subCategories Data info ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching subCategories data: $e');
    }
  }
}
