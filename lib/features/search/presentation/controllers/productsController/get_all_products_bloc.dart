import 'package:estore_client/features/search/domain/usecases/get_all_products_usecase.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_events.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, GetAllProductsStates> {
  final GetAllProductsUsecase getAllProductsUsecase;
  ProductsBloc(this.getAllProductsUsecase) : super(GetAllProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<GetAllProductsStates> emit,
  ) async {
    emit(GetAllProductsLoading());

    try {
      final products = await getAllProductsUsecase();
      emit(GetAllProductsLoaded(products));
    } catch (e) {
      print(e);
      emit(GetAllProductsError("Failed to load the products"));
    }
  }
}
