abstract class AddCustomerState {}

class AddCustomerInitial extends AddCustomerState {}

class AddCustomerLoading extends AddCustomerState {}

class AddCustomerSuccess extends AddCustomerState {
  final String message;

  AddCustomerSuccess(this.message);
}

class AddCustomerFailure extends AddCustomerState {
  final String error;

  AddCustomerFailure(this.error);
}
