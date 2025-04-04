import 'package:estore_client/auth/reqistration/domain/entites/add_customer.dart';

class AddCustomerModel extends AddCustomer {
  const AddCustomerModel({
    required super.firstName,
    required super.lastName,
    required super.password,
    required super.address,
    required super.phoneNumber,
  });

  factory AddCustomerModel.fromJson(Map<String, dynamic> json) {
    return AddCustomerModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      address: json['address'],
      phoneNumber: json['phone_number'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "address": address,
    };
  }

  factory AddCustomerModel.fromEntity(AddCustomer entity) {
    return AddCustomerModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      password: entity.password,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
    );
  }
}
