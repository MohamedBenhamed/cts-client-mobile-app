import 'dart:async';
import 'package:estore_client/features/home/domain/entites/get_all_subcategories.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_bloc.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_states.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_bloc.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_events.dart';
import 'package:estore_client/features/search/presentation/widgets/productListWidget.dart';
import 'package:estore_client/features/search/presentation/widgets/searchingBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  final int parameter;
  const SearchScreen({super.key, required this.parameter});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  late Set<int> _selectedTagIds;

  @override
  void initState() {
    super.initState();
    _selectedTagIds = {widget.parameter};
    _searchController.addListener(_onSearchChanged);
    if (widget.parameter != 0) {
      context.read<ProductsBloc>().add(FilterProducts(_selectedTagIds));
    } else {
      context.read<ProductsBloc>().add(LoadProducts());
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_searchController.text.trim().isEmpty) {
        context.read<ProductsBloc>().add(LoadProducts());
      } else {
        final query = _searchController.text.trim();
        _performSearchOrFilter(query, _selectedTagIds);
      }
    });
  }

  void _performSearchOrFilter(String query, Set<int> tagIds) {
    if (query.isEmpty) {
      if (tagIds.contains(0)) {
        context.read<ProductsBloc>().add(LoadProducts());
      } else {
        context.read<ProductsBloc>().add(FilterProducts(_selectedTagIds));
      }
    } else {
      if (tagIds.contains(0)) {
        context.read<ProductsBloc>().add(SearchProducts(query));
      } else {
        context.read<ProductsBloc>().add(SearchFilteredProducts(query, tagIds));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchingBar(
                controller: _searchController,
                onFilterPressed: () {
                  setState(() {
                    _selectedTagIds = {0};
                  });
                  _performSearchOrFilter("", _selectedTagIds);
                },
                onSearchChanged: _onSearchChanged,
              ),
              const SizedBox(height: 16.0),
              categoriesTags(),
              const SizedBox(height: 16.0),
              ProductsListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox categoriesTags() {
    return SizedBox(
      child: BlocBuilder<SubcategoryBloc, SubcategoryState>(
        builder: (context, state) {
          if (state is SubcategoryLoaded) {
            final tags = [
              GetAllSubCategories(
                id: 0,
                nameAr: "الكل",
                nameEn: "All",
                specsKey: [],
                categoryId: 0,
                iconUrl: "",
              ),
              ...state.subcategories,
            ];
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    tags.map((tag) {
                      final isSelected = _selectedTagIds.contains(tag.id);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: isSelected ? Colors.white : Colors.teal,
                            ),
                          ),
                          label: Text(tag.nameEn),
                          selected: isSelected,
                          selectedColor: Colors.teal,
                          labelStyle: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : Theme.of(
                                          context,
                                        ).textTheme.labelSmall?.color ??
                                        Colors.black,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              if (tag.id == 0) {
                                _selectedTagIds = {0};
                              } else {
                                _selectedTagIds.remove(0);
                                if (isSelected) {
                                  _selectedTagIds.remove(tag.id);
                                  if (_selectedTagIds.isEmpty) {
                                    _selectedTagIds = {0};
                                  }
                                } else {
                                  _selectedTagIds.add(tag.id);
                                }
                              }
                              _searchController.clear();
                            });
                            _performSearchOrFilter(
                              _searchController.text.trim(),
                              _selectedTagIds,
                            );
                          },
                        ),
                      );
                    }).toList(),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
