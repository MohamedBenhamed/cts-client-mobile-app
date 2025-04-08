import 'package:estore_client/features/search/domain/entites/productsHeader.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_bloc.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: BlocBuilder<ProductsBloc, GetAllProductsStates>(
        builder: (context, state) {
          if (state is GetAllProductsLoading) {
            return Text('loading');
          } else if (state is GetAllProductsLoaded) {
            return productsContainer(state.products, context);
          } else if (state is GetAllProductsError) {
            return Text('error');
          }
          return const Center(child: Text("No data available"));
        },
      ),
    );
  }
}

Container productsContainer(
  List<Productsheader> products,
  BuildContext context,
) {
  bool isRTL = Directionality.of(context) == TextDirection.rtl;
  return Container(
    key: Key('products'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Products',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                products.map((products) {
                  return item(context, products.name);
                }).toList(),
          ),
        ),
      ],
    ),
  );
}

Widget item(BuildContext context, String label) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers icon
          children: [],
        ),
      ),
      SizedBox(height: 5),
      SizedBox(
        width: 80,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
