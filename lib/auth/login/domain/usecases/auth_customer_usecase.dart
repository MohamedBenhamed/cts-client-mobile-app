import 'package:estore_client/auth/login/domain/entites/auth_customer.dart';
import 'package:estore_client/auth/login/domain/repositories/auth_customer_base_repository.dart';
import 'package:estore_client/core/error/result.dart';

class AuthCustomerUsecase {
  final BaseAuthCustomerRepository baseAuthCustomerRepository;
  AuthCustomerUsecase(this.baseAuthCustomerRepository);

  Future<Result<String>> execute(AuthCustomer authCustomer) async {
    try {
      final result = await baseAuthCustomerRepository.authCustomer(
        authCustomer,
      );
      return result;
    } catch (e) {
      return Result.failure('Unexpected error: ${e.toString()}', 500);
    }
  }
}
