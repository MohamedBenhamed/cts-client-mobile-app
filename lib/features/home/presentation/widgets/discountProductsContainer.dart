import 'package:estore_client/features/home/presentation/widgets/productCardWidget.dart';
import '../../../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_bloc.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';

Container discountProductsContainer(BuildContext context) {
  return Container(
    key: Key('discountProductsContainer'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            S.of(context).DiscountProducts,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 10),
        // BlocBuilder for products
        SizedBox(
          height: 380,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<ProductsBloc, GetAllProductsStates>(
            builder: (context, state) {
              if (state is GetAllProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetAllProductsLoaded) {
                final products =
                    List.from(state.products).where((p) {
                        final discountValue =
                            p.discount != null
                                ? double.tryParse(p.discount) ?? 0.0
                                : 0.0;
                        return discountValue > 0;
                      }).toList()
                      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                // Show horizontal scroll of ProductCards
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final stockStatus = context
                        .read<ProductsBloc>()
                        .getStockStatus(product);
                    final priceInfo = context.read<ProductsBloc>().getPriceInfo(
                      product,
                    );

                    return ProductCard(
                      brand: product.brandName,
                      name: product.name,
                      price:
                          "${priceInfo['originalPrice']?.toInt()} ${S.of(context).LYD}",
                      discountedPrice:
                          "${priceInfo['discountedPrice']?.toInt()} ${S.of(context).LYD}",
                      imagePath:
                          product.images.isNotEmpty
                              ? product.images[0]
                              : "assets/placeholder.png",
                    ).redacted(
                      context: context,
                      redact: false,
                      configuration: RedactedConfiguration(
                        animationDuration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                );
              } else if (state is GetAllProductsError) {
                return const Center(child: Text("Failed to load products"));
              }
              return const Center(child: Text("No data available"));
            },
          ),
        ),
      ],
    ),
  );
}
