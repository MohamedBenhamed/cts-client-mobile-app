import 'package:equatable/equatable.dart';
import 'package:estore_client/auth/login/domain/entites/auth_customer.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final AuthCustomer authCustomer;
  AuthLoginEvent(this.authCustomer);

  @override
  List<Object?> get props => [authCustomer];
}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}
