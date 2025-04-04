import 'package:estore_client/CustomerAccountSettings/domain/entites/get_customer_info_by_id.dart';

abstract class GetCustomerInfoByIdBaseRepository {
  Future<GetCustomerInfoById> getCustomerInfo(int customerId);
}
