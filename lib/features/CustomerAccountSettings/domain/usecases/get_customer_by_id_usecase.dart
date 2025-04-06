import 'package:estore_client/features/CustomerAccountSettings/domain/entites/get_customer_info_by_id.dart';
import 'package:estore_client/features/CustomerAccountSettings/domain/repositories/get_customer_info_by_id_base_repository.dart';

class GetCustomerInfoByIdUseCase {
  final GetCustomerInfoByIdBaseRepository getCustomerInfoByIdBaseRepository;

  GetCustomerInfoByIdUseCase(this.getCustomerInfoByIdBaseRepository);

  Future<GetCustomerInfoById> call(int customerID) async {
    return await getCustomerInfoByIdBaseRepository.getCustomerInfo(customerID);
  }
}
