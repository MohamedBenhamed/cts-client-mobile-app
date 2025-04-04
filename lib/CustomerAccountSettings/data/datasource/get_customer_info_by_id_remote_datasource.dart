import 'package:estore_client/CustomerAccountSettings/data/model/get_customer_info_model.dart';
import 'package:estore_client/core/network/api_constance.dart';
import 'package:estore_client/core/network/dio_client.dart';

abstract class BaseCustomerRemoteDataSource {
  Future<GetCustomerInfoModel> getCustomerInfo(int customerId);
}

class CustomerRemoteDataSourceImpl implements BaseCustomerRemoteDataSource {
  final DioClient dioClient;

  CustomerRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<GetCustomerInfoModel> getCustomerInfo(int customerId) async {
    try {
      final response = await dioClient.getById(
        ApiConstance.getCustomerInfoById,
        id: customerId,
      );
      if (response.statusCode == 200) {
        return GetCustomerInfoModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch customer info ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching customer info: $e');
    }
  }
}
