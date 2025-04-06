import 'package:equatable/equatable.dart';

abstract class AddCustomerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddNewCustomer extends AddCustomerEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String password;

  AddNewCustomer(
    this.firstName,
    this.lastName,
    this.password,
    this.phoneNumber,
    this.address,
  );

  @override
  List<Object> get props => [
    firstName,
    lastName,
    password,
    phoneNumber,
    address,
  ];
}
