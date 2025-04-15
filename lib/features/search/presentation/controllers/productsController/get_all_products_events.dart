abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {}

class SearchProducts extends ProductsEvent {
  final String query;
  SearchProducts(this.query);
}

class FilterProducts extends ProductsEvent {
  final Set<int> parameters;
  FilterProducts(this.parameters);
}

class SearchFilteredProducts extends ProductsEvent {
  final String query;
  final Set<int> subcategoryIds;

  SearchFilteredProducts(this.query, this.subcategoryIds);
}
