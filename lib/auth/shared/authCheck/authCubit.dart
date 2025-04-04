import 'package:estore_client/auth/login/data/datasource/auth_local_data_source.dart';
import 'package:estore_client/core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<bool?> {
  final BaseAuthLocalDataSource authLocalDataSource;

  AuthCubit()
    : authLocalDataSource = getIt<BaseAuthLocalDataSource>(),
      super(null); // Initial state is null

  Future<bool> checkAuthStatus() async {
    bool hasToken = await authLocalDataSource.hasToken();
    emit(hasToken);
    return hasToken; // Ensure a boolean value is always returned
  }

  Future<void> logout() async {
    await authLocalDataSource.clearToken();
    await authLocalDataSource.clearCustomerID();
    emit(false); // Emit false for logged out state
  }
}
