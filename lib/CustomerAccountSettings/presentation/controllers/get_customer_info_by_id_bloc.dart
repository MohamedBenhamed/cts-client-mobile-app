import 'package:estore_client/CustomerAccountSettings/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:estore_client/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_events.dart';
import 'package:estore_client/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estore_client/auth/login/data/datasource/auth_local_data_source.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomerInfoByIdUseCase getCustomerInfo;
  final BaseAuthLocalDataSource authLocalDataSource;

  CustomerBloc({
    required this.getCustomerInfo,
    required this.authLocalDataSource,
  }) : super(CustomerInitial()) {
    on<FetchCustomerInfo>((event, emit) async {
      emit(CustomerLoading());
      try {
        final customerID = await authLocalDataSource.getCustomerID();
        if (customerID == 0) {
          return;
        }
        final customer = await getCustomerInfo(customerID ?? 0);
        emit(CustomerLoaded(customer));
      } catch (e) {
        emit(CustomerError("Failed to fetch customer"));
      }
    });
  }
}
