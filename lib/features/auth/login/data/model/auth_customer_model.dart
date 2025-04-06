import 'package:estore_client/features/auth/login/domain/entites/auth_customer.dart';
import 'package:estore_client/features/auth/reqistration/domain/entites/add_customer.dart';

class AuthCustomerModel extends AuthCustomer {
  const AuthCustomerModel({
    required super.phoneNumber,
    required super.password,
  });

  factory AuthCustomerModel.fromJson(Map<String, dynamic> json) {
    return AuthCustomerModel(
      phoneNumber: json['phone_number'],
      password: json['password'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {"phone_number": phoneNumber, "password": password};
  }

  factory AuthCustomerModel.fromEntity(AddCustomer entity) {
    return AuthCustomerModel(
      phoneNumber: entity.phoneNumber,
      password: entity.password,
    );
  }
}
