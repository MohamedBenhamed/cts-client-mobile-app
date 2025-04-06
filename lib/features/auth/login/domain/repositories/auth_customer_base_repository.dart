import 'package:estore_client/features/auth/login/domain/entites/auth_customer.dart';
import 'package:estore_client/core/error/result.dart';

abstract class BaseAuthCustomerRepository {
  Future<Result<String>> authCustomer(AuthCustomer authCustomer);
}
