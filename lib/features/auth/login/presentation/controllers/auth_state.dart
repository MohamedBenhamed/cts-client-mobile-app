import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class Authenticated extends AuthState {
  final String token;
  final int customerID;

  Authenticated(this.token, this.customerID);

  @override
  List<Object?> get props => [token];
}
