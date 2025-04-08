import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_bloc.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductsBloc, GetAllProductsStates>(
          builder: (context, state) {
            if (state is GetAllProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAllProductsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Search Field
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search, size: 30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.teal,
                                ),
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
                            onChanged: (value) {},
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.tune_outlined, size: 30),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.products.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Image
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.teal[50],
                                    ),
                                    child: Stack(
                                      children: [
                                        // Image background
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                          child: Image.asset(
                                            product.images[0],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        // Only show ribbon if discount > 0
                                        if (double.tryParse(product.discount) !=
                                                null &&
                                            double.parse(product.discount) > 0)
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
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(
                                                    8,
                                                  ),
                                                  topLeft: Radius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                '-${(double.parse(product.discount) * 100).toInt()}%',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
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
                                        const Text(
                                          'Samsung',
                                          style: TextStyle(fontSize: 12),
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

                                        // Price display: show discounted price and original price if discount > 0
                                        if (double.parse(product.discount) >
                                            0) ...[
                                          Text(
                                            '${double.parse(product.price).toInt()} LYD',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '${(double.parse(product.price) * (1 - double.parse(product.discount))).toInt()} LYD',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ] else
                                          Text(
                                            '${double.parse(product.price).toInt()} LYD',
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is GetAllProductsError) {
              return const Center(child: Text('Error loading products'));
            }

            return const Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }
}
