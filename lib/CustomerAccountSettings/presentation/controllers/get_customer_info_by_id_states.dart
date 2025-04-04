import 'package:estore_client/CustomerAccountSettings/domain/entites/get_customer_info_by_id.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final GetCustomerInfoById customer;
  CustomerLoaded(this.customer);
}

class CustomerError extends CustomerState {
  final String message;
  CustomerError(this.message);
}
