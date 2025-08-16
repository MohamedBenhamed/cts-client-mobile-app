import 'package:estore_client/features/home/presentation/widgets/productCardWidget.dart';

import '../../../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

Container bestSellingContainer(BuildContext context) {
  return Container(
    key: Key('bestSelling'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            S.of(context).BestSellers,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 380, // Set a fixed height
          width: MediaQuery.of(context).size.width, // Set a finite width
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ProductCard(
                brand: "Samsung",
                name: "Samsung Galaxy S24 Ultra",
                price: "7000 ${S.of(context).LYD}",
                imagePath:
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
              ProductCard(
                brand: "Samsung",
                name: "Samsung Galaxy S24 Ultra",
                price: "7000 ${S.of(context).LYD}",
                imagePath:
                    "assets/products/smartPhones/SamsungGalaxyS24Ultra.webp",
              ),
            ],
          ).redacted(
            context: context,
            redact: true,
            configuration: RedactedConfiguration(
              animationDuration: const Duration(milliseconds: 800), //default
            ),
          ),
        ),
      ],
    ),
  );
}
