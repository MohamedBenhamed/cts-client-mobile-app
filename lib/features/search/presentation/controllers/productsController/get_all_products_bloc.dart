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
      print(e);
      emit(GetAllProductsError("Failed to load the products"));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      // If query is empty, show all products
      emit(GetAllProductsLoaded(_allProducts));
    } else {
      final filtered =
          _allProducts.where((product) {
            return product.name.toLowerCase().contains(query);
          }).toList();

      emit(GetAllProductsLoaded(filtered));
    }
  }
}
