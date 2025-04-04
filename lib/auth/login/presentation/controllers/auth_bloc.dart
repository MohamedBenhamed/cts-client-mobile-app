// auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:estore_client/auth/login/domain/usecases/auth_customer_usecase.dart';
import 'package:estore_client/auth/login/data/datasource/auth_local_data_source.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthCustomerUsecase authCustomerUsecase;
  final BaseAuthLocalDataSource authLocalDataSource;

  AuthBloc(this.authCustomerUsecase, this.authLocalDataSource)
    : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthCheckStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await authCustomerUsecase.execute(event.authCustomer);

    if (result.data != null) {
      await authLocalDataSource.saveToken(result.data!, result.customerId);

      emit(Authenticated(result.data!, result.customerId));
    } else {
      emit(AuthFailure(result.error ?? "Login failed"));
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    await authLocalDataSource.clearToken();
    await authLocalDataSource.clearCustomerID(); // Clear the saved token
    emit(AuthInitial()); // After logout, set the state to initial
  }

  Future<void> _onCheckAuthStatus(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final token = await authLocalDataSource.getToken();
    final customerID = await authLocalDataSource.getCustomerID();

    if (token != null && customerID != null) {
      emit(Authenticated(token, customerID));
    } else {
      emit(AuthInitial());
    }
  }
}
