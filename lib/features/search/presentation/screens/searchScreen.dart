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
  bool inStockOnly = false;

  @override
  void initState() {
    super.initState();
    _selectedTagIds = {widget.parameter};
    _searchController.addListener(_onSearchChanged);
    _loadInitialData();
  }

  void _loadInitialData() {
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
      final query = _searchController.text.trim();
      _performSearchOrFilter(query, _selectedTagIds);
    });
  }

  void _performSearchOrFilter(String query, Set<int> tagIds) {
    if (query.isEmpty) {
      if (tagIds.contains(0) && !inStockOnly) {
        context.read<ProductsBloc>().add(LoadProducts());
      } else if (tagIds.contains(0) && inStockOnly) {
        context.read<ProductsBloc>().add(
          FilterProducts(tagIds, stock: inStockOnly),
        );
      } else {
        context.read<ProductsBloc>().add(FilterProducts(tagIds));
      }
    } else {
      if (tagIds.contains(0) || !inStockOnly) {
        context.read<ProductsBloc>().add(SearchProducts(query));
      } else if (tagIds.contains(0) || inStockOnly) {
        context.read<ProductsBloc>().add(
          FilterProducts(tagIds, query: query, stock: inStockOnly),
        );
      }
    }
  }

  Future<void> _refreshData() async {
    _performSearchOrFilter(_searchController.text.trim(), _selectedTagIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              color: Colors.teal,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: SearchingBar(
                          controller: _searchController,
                          onFilterPressed: () {
                            setState(() {
                              _selectedTagIds = {0};
                            });
                            _performSearchOrFilter("", _selectedTagIds);
                          },
                          onSearchChanged: _onSearchChanged,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await filterBottomSheet(context);
                        },
                        icon: const Icon(Icons.tune_outlined, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const ProductsListWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> filterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text('Categories'),
                    categoriesTags(setModalState),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: Colors.teal,
                      title: const Text("In Stock Only"),
                      value: inStockOnly,
                      onChanged: (value) {
                        setModalState(() {
                          inStockOnly = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ProductsBloc>().add(
                            GetOnlyInStock(inStockOnly),
                          );
                          _performSearchOrFilter(
                            _searchController.text.trim(),
                            _selectedTagIds,
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  SizedBox categoriesTags(void Function(void Function()) setModalState) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
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
              child: SizedBox(
                width: 400,
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children:
                      tags.map((tag) {
                        final isSelected = _selectedTagIds.contains(tag.id);
                        return FilterChip(
                          checkmarkColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: isSelected ? Colors.white : Colors.teal,
                            ),
                          ),
                          label: Text(isRTL ? tag.nameAr : tag.nameEn),
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
                            setModalState(() {
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
                          },
                        );
                      }).toList(),
                ),
              ),
            );
          } else if (state is SubcategoryError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is SubcategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
