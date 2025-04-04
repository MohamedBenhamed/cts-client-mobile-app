import 'package:estore_client/core/error/result.dart';
import 'package:estore_client/core/network/api_constance.dart';
import 'package:estore_client/core/network/dio_client.dart';

abstract class BaseAuthRemoteDataSource {
  Future<Result<String>> login(Map<String, dynamic> customerAuthData);
}

class AuthRemoteDataSourceImpl extends BaseAuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<Result<String>> login(Map<String, dynamic> customerAuthData) async {
    try {
      final response = await dioClient.post(
        ApiConstance.logIn,
        data: customerAuthData,
      );
      if (response.statusCode == 200) {
        String token = response.data['access'];
        int customerID = response.data['id'];
        return Result.success(token, customerID);
      } else {
        return Result.failure(
          'Failed to log in: ${response.data['message']}',
          response.statusCode ?? 500,
        );
      }
    } catch (e) {
      return Result.failure('Unexpected error: ${e.toString()}', 500);
    }
  }
}
