import 'package:estore_client/auth/reqistration/domain/entites/add_customer.dart';
import 'package:estore_client/core/error/result.dart';

abstract class BaseAddCustomerRepository {
  Future<Result<bool>> addCustomer(AddCustomer addCustomer);
}
