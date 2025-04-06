import 'package:estore_client/features/auth/reqistration/domain/entites/add_customer.dart';
import 'package:estore_client/features/auth/reqistration/domain/usecases/add_customer_usecase.dart';
import 'package:estore_client/features/auth/reqistration/presentation/controller/customer_event.dart';
import 'package:estore_client/features/auth/reqistration/presentation/controller/customer_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  final AddNewCustomerUseCase addNewCustomerUseCase;

  AddCustomerBloc(this.addNewCustomerUseCase) : super(AddCustomerInitial()) {
    on<AddNewCustomer>((event, emit) async {
      emit(AddCustomerLoading());

      AddCustomer customerData = AddCustomer(
        firstName: event.firstName,
        lastName: event.lastName,
        address: event.address,
        password: event.password,
        phoneNumber: event.phoneNumber,
      );

      final result = await addNewCustomerUseCase.execute(customerData);

      if (result.data == true) {
        emit(AddCustomerSuccess("تمت الإضافة بنجاح"));
      } else {
        emit(AddCustomerFailure(result.error ?? "حدث خطأ غير متوقع"));
      }
    });
  }
}
