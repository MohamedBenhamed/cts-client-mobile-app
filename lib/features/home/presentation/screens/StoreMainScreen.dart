import 'package:estore_client/features/home/presentation/widgets/adSpace.dart';
import 'package:estore_client/features/home/presentation/widgets/bestSellingContainer.dart';
import 'package:estore_client/features/home/presentation/widgets/discountProductsContainer.dart';
import 'package:estore_client/features/home/presentation/widgets/greetingSection.dart';
import 'package:estore_client/features/home/presentation/widgets/categoriesContainer.dart';
import 'package:estore_client/features/home/presentation/widgets/imageSlider.dart';
import 'package:estore_client/features/home/presentation/widgets/newArrivalsContainer.dart';
import 'package:estore_client/features/home/presentation/widgets/popularProductsContainer.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_bloc.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_events.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';

class StoreMainScreen extends StatefulWidget {
  const StoreMainScreen({super.key});

  @override
  _StoreMainScreenState createState() => _StoreMainScreenState();
}

class _StoreMainScreenState extends State<StoreMainScreen>
    with SingleTickerProviderStateMixin {
  Future<void> _refreshData() async {
    final productsBloc = context.read<ProductsBloc>();
    productsBloc.add(LoadProducts());
    await productsBloc.stream.firstWhere(
      (state) => state is! GetAllProductsLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                greetingSection(context),
                imageSlider(context),
                SizedBox(height: 25),
                categoryList(context),
                SizedBox(height: 25),
                NewArrivalsContainer(),
                SizedBox(height: 25),
                adBanner(context, "assets/sliderImages/image8.png"),
                SizedBox(height: 25),
                discountProductsContainer(context),
                SizedBox(height: 25),
                adBanner(context, "assets/sliderImages/image5.png"),
                SizedBox(height: 25),
                bestSellingContainer(context),
                SizedBox(height: 25),
                adBanner(context, "assets/sliderImages/image7.jpg"),
                SizedBox(height: 25),
                popularProductsContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
