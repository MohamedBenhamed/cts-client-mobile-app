import 'package:estore_client/features/auth/reqistration/data/datasource/add_customer_remote_data_source.dart';
import 'package:estore_client/features/auth/reqistration/domain/entites/add_customer.dart';
import 'package:estore_client/features/auth/reqistration/domain/repositories/add_customer_base_repository.dart';
import 'package:estore_client/core/error/result.dart';

class AddCustomerRepository extends BaseAddCustomerRepository {
  final BaseAddCustomerRemoteDataSource baseAddCustomerRemoteDataSource;
  AddCustomerRepository(this.baseAddCustomerRemoteDataSource);

  @override
  Future<Result<bool>> addCustomer(AddCustomer addCustomer) async {
    try {
      final result = await baseAddCustomerRemoteDataSource.addNewCustomer(
        addCustomer.toJson(),
      );

      return result; // Directly return the `Result` object
    } catch (e) {
      return Result.failure('Unexpected error: ${e.toString()}', 500);
    }
  }
}
