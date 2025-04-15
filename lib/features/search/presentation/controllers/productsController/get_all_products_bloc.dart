import 'package:estore_client/features/search/domain/entites/productsHeader.dart';
import 'package:estore_client/features/search/domain/usecases/get_all_products_usecase.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_events.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, GetAllProductsStates> {
  final GetAllProductsUsecase getAllProductsUsecase;
  List<Productsheader> _allProducts = [];

  ProductsBloc(this.getAllProductsUsecase) : super(GetAllProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<FilterProducts>(_onFilterProducts);
    on<SearchFilteredProducts>(_onSearchFilteredProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    emit(GetAllProductsLoading());
    try {
      final products = await getAllProductsUsecase();
      _allProducts = products;
      emit(GetAllProductsLoaded(products));
    } catch (e) {
      emit(GetAllProductsError("Failed to load the products"));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    final query = event.query.trim().toLowerCase();
    final filtered = _filterProducts(query: query);
    emit(GetAllProductsLoaded(filtered));
  }

  Future<void> _onFilterProducts(
    FilterProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    final parameters = event.parameters;

    // Show all products if "All" is selected
    if (parameters.isEmpty || parameters.contains(0)) {
      emit(GetAllProductsLoaded(_allProducts));
    } else {
      final filtered = _filterProducts(subcategoryIds: parameters);
      emit(GetAllProductsLoaded(filtered));
    }
  }

  Future<void> _onSearchFilteredProducts(
    SearchFilteredProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    final query = event.query.trim().toLowerCase();
    final filtered = _filterProducts(
      query: query,
      subcategoryIds: event.subcategoryIds,
    );
    emit(GetAllProductsLoaded(filtered));
  }

  /// ✅ Reusable filtering method
  List<Productsheader> _filterProducts({
    String query = '',
    Set<int> subcategoryIds = const {},
    int? categoryId,
  }) {
    return _allProducts.where((product) {
      final matchesQuery =
          query.isEmpty || product.name.toLowerCase().contains(query);
      final matchesSubcategory =
          subcategoryIds.isEmpty ||
          subcategoryIds.contains(product.subcategoryId);
      final matchesCategory =
          categoryId == null || product.categoryId == categoryId;

      return matchesQuery && matchesSubcategory && matchesCategory;
    }).toList();
  }

  // Stock status helper
  String getStockStatus(Productsheader product) {
    return product.isOutOfStock ? 'Out of stock' : '';
  }

  // Price info helper
  Map<String, double> getPriceInfo(Productsheader product) {
    return {
      'discountedPrice': product.discountedPrice,
      'originalPrice': product.originalPrice,
    };
  }
}
