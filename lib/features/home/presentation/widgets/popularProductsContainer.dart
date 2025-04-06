import '../../../../../generated/l10n.dart';
import 'package:estore_client/features/product/product_details/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

Container popularProductsContainer(BuildContext context) {
  return Container(
    key: const Key('popularProducts'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            S.of(context).PopularProducts,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 306, // Fixed height
          width: MediaQuery.of(context).size.width, // Constrained width
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              productCard(
                context,
                "EA",
                "EA FC 25",
                "365 ${S.of(context).LYD}",
                "assets/products/smartPhones/SamsungGalaxyS24Ultra.webp",
              ).redacted(
                context: context,
                redact: false,
                configuration: RedactedConfiguration(
                  animationDuration: const Duration(
                    milliseconds: 800,
                  ), //default
                ),
              ),

              productCard(
                context,
                "Fromsoftware",
                "Elden Ring DLC",
                "365 ${S.of(context).LYD}",
                "assets/products/ps5games/eldenringDLC.jpg",
              ).redacted(
                context: context,
                redact: false,
                configuration: RedactedConfiguration(
                  animationDuration: const Duration(
                    milliseconds: 800,
                  ), //default
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget productCard(
  BuildContext context,
  String brand,
  String title,
  String price,
  String imagePath, {
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: () {
      if (onTap != null) {
        onTap();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
        );
      }
    },
    child: Container(
      width: 250,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagePath, height: 165, fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 125,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(brand, style: Theme.of(context).textTheme.displaySmall),
                SizedBox(height: 20),
                Text(title, style: Theme.of(context).textTheme.displayMedium),
                SizedBox(height: 20),
                Text(price, style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
