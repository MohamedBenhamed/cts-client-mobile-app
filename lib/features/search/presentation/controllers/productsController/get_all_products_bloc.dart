import 'package:estore_client/features/search/domain/entites/productsHeader.dart';
import 'package:estore_client/features/search/domain/usecases/get_all_products_usecase.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_events.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, GetAllProductsStates> {
  final GetAllProductsUsecase getAllProductsUsecase;

  List<Productsheader> _allProducts = [];

  // 🔥 Active filters
  String _currentQuery = '';
  Set<int> _currentSubcategoryIds = {};
  int? _currentCategoryId;
  bool _onlyInStock = false;

  ProductsBloc(this.getAllProductsUsecase) : super(GetAllProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<FilterProducts>(_onFilterProducts);
    on<SearchFilteredProducts>(_onSearchFilteredProducts);
    on<GetOnlyInStock>(_onGetOnlyInStock);
  }

  // 🚀 Load all products and apply filters if any
  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    emit(GetAllProductsLoading());
    try {
      final products = await getAllProductsUsecase();
      _allProducts.clear();
      _allProducts.addAll(products);
      emit(GetAllProductsLoaded(_applyFilters(isAll: true)));
    } catch (e) {
      emit(GetAllProductsError("Failed to load the products"));
    }
  }

  // 🔍 Update query and apply filters
  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    _currentQuery = event.query.trim().toLowerCase();
    emit(GetAllProductsLoaded(_applyFilters()));
  }

  // 🧃 Update subcategory filter and apply
  Future<void> _onFilterProducts(
    FilterProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    final subcategories = event.parameters;
    print(subcategories);

    // 👉 If 0 (All) is selected, ignore subcategory filtering
    if (subcategories.contains(0)) {
      _currentSubcategoryIds = {};
      print(event.stock);
      _onlyInStock = event.stock;
    } else {
      print(event.stock);
      _currentQuery = event.query.trim().toLowerCase();
      _currentSubcategoryIds = subcategories;
    }

    emit(GetAllProductsLoaded(_applyFilters()));
  }

  // 🔍 Subcategory + query
  Future<void> _onSearchFilteredProducts(
    SearchFilteredProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    _currentQuery = event.query.trim().toLowerCase();

    // 👉 If 0 (All) is selected, ignore subcategory filtering
    if (event.subcategoryIds.contains(0)) {
      _currentSubcategoryIds = {};
    } else {
      _currentSubcategoryIds = event.subcategoryIds;
    }

    emit(GetAllProductsLoaded(_applyFilters()));
  }

  // ✅ Toggle "in stock only"
  Future<void> _onGetOnlyInStock(
    GetOnlyInStock event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    _onlyInStock = event.stock;
    emit(GetAllProductsLoaded(_applyFilters()));
  }

  // 🧠 Apply all active filters to _allProducts
  List<Productsheader> _applyFilters({bool isAll = false}) {
    if (isAll) {
      return _allProducts;
    }
    return _allProducts.where((product) {
      final matchesQuery =
          _currentQuery.isEmpty ||
          product.name.toLowerCase().contains(_currentQuery);

      final matchesSubcategory =
          _currentSubcategoryIds.isEmpty ||
          _currentSubcategoryIds.contains(product.subcategoryId);

      final matchesCategory =
          _currentCategoryId == null ||
          product.categoryId == _currentCategoryId;

      final matchesStock = !_onlyInStock || !product.isOutOfStock;

      return matchesQuery &&
          matchesSubcategory &&
          matchesCategory &&
          matchesStock;
    }).toList();
  }

  // 🏷️ Stock status helper
  String getStockStatus(Productsheader product) {
    return product.isOutOfStock ? 'Out of stock' : '';
  }

  // 💰 Price helper
  Map<String, double> getPriceInfo(Productsheader product) {
    return {
      'discountedPrice': product.discountedPrice,
      'originalPrice': product.originalPrice,
    };
  }
}
