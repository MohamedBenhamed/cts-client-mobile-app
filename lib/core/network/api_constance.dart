import 'dart:io';

class ApiConstance {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api';
    } else {
      return 'http://127.0.0.1:8000/api';
    }
  }

  static String get registration => "$baseUrl/register/";
  static String get logIn => "$baseUrl/login/";
  static String get getCustomerInfoById => "$baseUrl/customer";
  static String get getSubCategories => "$baseUrl/subcategories/";
  static String get getProductsHeaders => "$baseUrl/products/";
}
