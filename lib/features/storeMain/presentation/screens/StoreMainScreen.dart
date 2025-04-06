import 'package:estore_client/features/storeMain/presentation/widgets/greetingSection.dart';
import 'package:estore_client/features/storeMain/presentation/widgets/categoriesContainer.dart';
import 'package:estore_client/features/storeMain/presentation/widgets/imageSlider.dart';
import 'package:estore_client/features/storeMain/presentation/widgets/newArrivalsContainer.dart';
import 'package:estore_client/features/storeMain/presentation/widgets/popularProductsContainer.dart';
import 'package:flutter/material.dart';

class StoreMainScreen extends StatefulWidget {
  const StoreMainScreen({super.key});

  @override
  _StoreMainScreenState createState() => _StoreMainScreenState();
}

class _StoreMainScreenState extends State<StoreMainScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              greetingSection(context),
              imageSlider(context),
              SizedBox(height: 25),
              categoryList(context),
              SizedBox(height: 10),
              newArrivalsContainer(context),
              SizedBox(height: 20),
              popularProductsContainer(context),
            ],
          ),
        ),
      ),
    );
  }
}
