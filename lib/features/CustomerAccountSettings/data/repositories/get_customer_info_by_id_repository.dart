import 'package:estore_client/features/CustomerAccountSettings/data/datasource/get_customer_info_by_id_remote_datasource.dart';
import 'package:estore_client/features/CustomerAccountSettings/domain/entites/get_customer_info_by_id.dart';
import 'package:estore_client/features/CustomerAccountSettings/domain/repositories/get_customer_info_by_id_base_repository.dart';

class GetCustomerInfoByIdRepository extends GetCustomerInfoByIdBaseRepository {
  final BaseCustomerRemoteDataSource baseCustomerRemoteDataSource;

  GetCustomerInfoByIdRepository(this.baseCustomerRemoteDataSource);

  @override
  Future<GetCustomerInfoById> getCustomerInfo(int customerId) async {
    return await baseCustomerRemoteDataSource.getCustomerInfo(customerId);
  }
}
