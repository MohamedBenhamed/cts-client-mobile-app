import 'package:estore_client/features/CustomerAccountSettings/domain/entites/get_customer_info_by_id.dart';

class GetCustomerInfoModel extends GetCustomerInfoById {
  const GetCustomerInfoModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.address,
  });

  factory GetCustomerInfoModel.fromJson(Map<String, dynamic> json) {
    return GetCustomerInfoModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
    );
  }
}
