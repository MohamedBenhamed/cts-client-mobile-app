import 'dart:async';
import 'package:estore_client/features/home/domain/entites/get_all_subcategories.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_bloc.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_states.dart';
import 'package:estore_client/features/product/product_details/presentation/screens/product_details_screen.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_bloc.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_events.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';
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
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      _performSearchOrFilter(query, _selectedTagIds);
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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.teal,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedTagIds = {0};
                      });
                      _performSearchOrFilter("", _selectedTagIds);
                    },
                    icon: const Icon(Icons.tune_outlined, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // ✅ TAGS START HERE (MULTI-SELECT)
              BlocBuilder<SubcategoryBloc, SubcategoryState>(
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
                              final isSelected = _selectedTagIds.contains(
                                tag.id,
                              );
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChip(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.teal,
                                    ),
                                  ),
                                  label: Text(tag.nameAr),
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
              const SizedBox(height: 16.0),
              Expanded(
                child: BlocBuilder<ProductsBloc, GetAllProductsStates>(
                  builder: (context, state) {
                    if (state is GetAllProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetAllProductsLoaded) {
                      final products = state.products;

                      if (products.isEmpty) {
                        return const Center(child: Text('No products found.'));
                      }
                      return ListView(
                        padding: const EdgeInsets.only(bottom: 16),
                        children: List.generate(products.length * 2 - 1, (
                          index,
                        ) {
                          if (index.isOdd) {
                            return const SizedBox(height: 16);
                          }

                          final productIndex = index ~/ 2;
                          final product = products[productIndex];
                          final stockStatus = context
                              .read<ProductsBloc>()
                              .getStockStatus(product);
                          final priceInfo = context
                              .read<ProductsBloc>()
                              .getPriceInfo(product);
                          double originalPrice =
                              double.tryParse(product.price) ?? 0.0;
                          double discountedPrice = originalPrice;

                          if (double.tryParse(product.discount) != null &&
                              double.parse(product.discount) > 0) {
                            discountedPrice =
                                originalPrice *
                                (1 - double.parse(product.discount));
                          }

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ProductDetailsScreen(
                                        product: product,
                                        stockStatus: stockStatus,
                                        priceInfo: {
                                          'originalPrice': originalPrice,
                                          'discountedPrice': discountedPrice,
                                        },
                                      ),
                                ),
                              );
                            },
                            child: TweenAnimationBuilder<Offset>(
                              tween: Tween(
                                begin: Offset(1, 0),
                                end: Offset(0, 0),
                              ),
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                              builder: (context, offset, child) {
                                return Transform.translate(
                                  offset: offset * 200,
                                  child: child,
                                );
                              },
                              child: Card(
                                elevation: 1,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                          color: Colors.teal[50],
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                product.images[0],
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            if (product.discount.isNotEmpty &&
                                                double.parse(product.discount) >
                                                    0)
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                8,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                  ),
                                                  child: Text(
                                                    '${(double.parse(product.discount) * 100).toInt()}%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.brandName,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            if (stockStatus.isNotEmpty)
                                              Text(
                                                stockStatus,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            if (!stockStatus.isNotEmpty)
                                              if (priceInfo['originalPrice']! >
                                                  0)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${priceInfo['originalPrice']!.toInt()} LYD',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${priceInfo['discountedPrice']!.toInt()} LYD',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              else
                                                Text(
                                                  '${priceInfo['discountedPrice']!.toInt()} LYD',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    } else if (state is GetAllProductsError) {
                      return const Center(
                        child: Text("Failed to load the products"),
                      );
                    }
                    return const Center(child: Text("No data available"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
