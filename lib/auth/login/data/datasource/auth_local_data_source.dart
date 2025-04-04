import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuthLocalDataSource {
  Future<void> saveToken(String token, int customerID);
  Future<String?> getToken();
  Future<int?> getCustomerID();
  Future<void> clearToken();
  Future<void> clearCustomerID();
  Future<bool> hasToken();
}

class AuthLocalDataSourceImpl extends BaseAuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl(this.sharedPreferences);

  static const String _accessTokenKey = "ACCESS_TOKEN";
  static const String _customerID = "CustomerID";

  @override
  Future<void> saveToken(String token, int customerID) async {
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setInt(_customerID, customerID);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_accessTokenKey);
  }

  @override
  Future<int?> getCustomerID() async {
    return sharedPreferences.getInt(_customerID);
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(_accessTokenKey);
  }

  @override
  Future<void> clearCustomerID() async {
    await sharedPreferences.remove(_customerID);
  }

  @override
  Future<bool> hasToken() async {
    return sharedPreferences.containsKey(_accessTokenKey);
  }
}
