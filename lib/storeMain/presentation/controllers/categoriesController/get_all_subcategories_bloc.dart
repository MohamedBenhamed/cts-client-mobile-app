// Bloc Events
import 'package:estore_client/storeMain/domain/usecases/get_all_subcategories_usecase.dart';
import 'package:estore_client/storeMain/presentation/controllers/categoriesController/get_all_subcategories_events.dart';
import 'package:estore_client/storeMain/presentation/controllers/categoriesController/get_all_subcategories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcategoryBloc extends Bloc<SubcategoryEvent, SubcategoryState> {
  final GetAllSubCategoriesUseCase getAllSubCategoriesUseCase;

  SubcategoryBloc(this.getAllSubCategoriesUseCase)
    : super(SubcategoryInitial()) {
    on<LoadSubcategories>(_onLoadSubcategories);
  }

  Future<void> _onLoadSubcategories(
    LoadSubcategories event,
    Emitter<SubcategoryState> emit,
  ) async {
    emit(SubcategoryLoading());

    try {
      final subcategories = await getAllSubCategoriesUseCase();
      emit(SubcategoryLoaded(subcategories));
    } catch (e) {
      print(e);
      emit(SubcategoryError("Failed to load subcategories"));
    }
  }
}
