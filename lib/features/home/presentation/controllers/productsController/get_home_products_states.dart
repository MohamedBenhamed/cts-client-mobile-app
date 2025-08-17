import 'package:estore_client/features/search/domain/entites/productsHeader.dart';

class GetAllProductsStates {}

class GetAllProductsInitial extends GetAllProductsStates {}

class GetAllProductsLoading extends GetAllProductsStates {}

class GetAllProductsLoaded extends GetAllProductsStates {
  final List<Productsheader> products;
  GetAllProductsLoaded(this.products);
}

class GetAllProductsError extends GetAllProductsStates {
  final String message;
  GetAllProductsError(this.message);
}
