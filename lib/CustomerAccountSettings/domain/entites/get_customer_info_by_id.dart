import 'package:equatable/equatable.dart';

class GetCustomerInfoById extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;

  const GetCustomerInfoById({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "address": address,
    };
  }

  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber, address];
}
