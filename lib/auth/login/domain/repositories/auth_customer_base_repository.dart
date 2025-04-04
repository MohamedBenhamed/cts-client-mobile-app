import 'package:estore_client/auth/login/domain/entites/auth_customer.dart';
import 'package:estore_client/core/error/result.dart';

abstract class BaseAuthCustomerRepository {
  Future<Result<String>> authCustomer(AuthCustomer authCustomer);
}
