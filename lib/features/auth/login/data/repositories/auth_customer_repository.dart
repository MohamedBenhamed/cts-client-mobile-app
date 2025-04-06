import 'package:estore_client/features/auth/login/data/datasource/auth_local_data_source.dart';
import 'package:estore_client/features/auth/login/data/datasource/auth_remote_data_source.dart';
import 'package:estore_client/features/auth/login/domain/entites/auth_customer.dart';
import 'package:estore_client/features/auth/login/domain/repositories/auth_customer_base_repository.dart';
import 'package:estore_client/core/error/result.dart';

class AuthCustomerRepository extends BaseAuthCustomerRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  final BaseAuthLocalDataSource baseAuthLocalDataSource;

  AuthCustomerRepository(
    this.baseAuthRemoteDataSource,
    this.baseAuthLocalDataSource,
  );

  @override
  Future<Result<String>> authCustomer(AuthCustomer authCustomer) async {
    try {
      final result = await baseAuthRemoteDataSource.login(
        authCustomer.toJson(),
      );
      if (result.isSuccess) {
        await baseAuthLocalDataSource.saveToken(
          result.data!,
          result.customerId,
        );
      }
      return result;
    } catch (e) {
      return Result.failure('Unexpected error: ${e.toString()}', 500);
    }
  }
}
