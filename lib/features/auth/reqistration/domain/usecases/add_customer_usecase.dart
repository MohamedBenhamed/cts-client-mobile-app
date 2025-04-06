import 'package:estore_client/features/auth/reqistration/domain/entites/add_customer.dart';
import 'package:estore_client/features/auth/reqistration/domain/repositories/add_customer_base_repository.dart';
import 'package:estore_client/core/error/result.dart';

class AddNewCustomerUseCase {
  final BaseAddCustomerRepository baseAddCustomerRepository;
  AddNewCustomerUseCase(this.baseAddCustomerRepository);

  Future<Result<bool>> execute(AddCustomer addCustomer) async {
    try {
      final result = await baseAddCustomerRepository.addCustomer(addCustomer);
      return result;
    } catch (e) {
      return Result.failure('Unexpected error: ${e.toString()}', 500);
    }
  }
}
