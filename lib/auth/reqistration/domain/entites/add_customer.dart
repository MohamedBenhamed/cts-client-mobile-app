import 'package:equatable/equatable.dart';

class AddCustomer extends Equatable {
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String address;

  const AddCustomer({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "phone_number": phoneNumber,
      "address": address,
    };
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    password,
    phoneNumber,
    address,
  ];
}
