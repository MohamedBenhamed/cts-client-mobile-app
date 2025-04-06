import 'package:estore_client/core/error/result.dart';
import 'package:estore_client/core/network/api_constance.dart';
import 'package:estore_client/core/network/dio_client.dart';

abstract class BaseAddCustomerRemoteDataSource {
  Future<Result<bool>> addNewCustomer(Map<String, dynamic> customerData);
}

class AddCustomerRemoteDataSource extends BaseAddCustomerRemoteDataSource {
  final DioClient dioClient;

  AddCustomerRemoteDataSource(this.dioClient);

  @override
  Future<Result<bool>> addNewCustomer(Map<String, dynamic> customerData) async {
    try {
      final response = await dioClient.post(
        ApiConstance.registration,
        data: customerData,
      );

      if (response.statusCode == 201) {
        return Result.success(true, response.data['phone_number']);
      } else if (response.statusCode == 400) {
        final errorMessage = response.data['phone_number']?.first;
        if (errorMessage != null &&
            errorMessage == "This phone number is already registered.") {
          return Result.failure(
            'Phone number is already registered',
            response.statusCode ?? 500,
          );
        }
        return Result.failure(
          'Invalid request: ${response.data}',
          response.statusCode ?? 500,
        );
      } else {
        return Result.failure(
          'Failed to create customer: ${response.data}',
          response.statusCode ?? 500,
        );
      }
    } catch (e) {
      return Result.failure('Unexpected error: ${e.toString()}', 500);
    }
  }
}
