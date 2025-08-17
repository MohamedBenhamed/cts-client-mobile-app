abstract class ProductsEvent {}

class LoadHomeProducts extends ProductsEvent {}

class SearchProducts extends ProductsEvent {
  final String query;
  SearchProducts(this.query);
}

class FilterProducts extends ProductsEvent {
  final Set<int> parameters;
  final String query;
  final bool stock;

  FilterProducts(this.parameters, {this.query = "", this.stock = false});
}

class SearchFilteredProducts extends ProductsEvent {
  final String query;
  final Set<int> subcategoryIds;

  SearchFilteredProducts(this.query, this.subcategoryIds);
}

class GetOnlyInStock extends ProductsEvent {
  final bool stock;
  GetOnlyInStock(this.stock);
}
