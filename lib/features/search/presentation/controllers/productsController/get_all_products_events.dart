abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {}

class SearchProducts extends ProductsEvent {
  final String query;
  SearchProducts(this.query);
}
