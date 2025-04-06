import 'package:equatable/equatable.dart';

class AuthCustomer extends Equatable {
  final String phoneNumber;
  final String password;

  const AuthCustomer({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {"phone_number": phoneNumber, "password": password};
  }

  @override
  List<Object?> get props => [phoneNumber, password];
}
