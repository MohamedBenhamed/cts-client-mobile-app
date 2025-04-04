import '../../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

Container newArrivalsContainer(BuildContext context) {
  return Container(
    key: Key('newArrivals'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            S.of(context).NewArrivals,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 306, // Set a fixed height
          width: MediaQuery.of(context).size.width, // Set a finite width
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              productCard(
                context,
                "Samsung",
                "Samsung Galaxy S24 Ultra",
                "7000 ${S.of(context).LYD}",
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
                "Apple",
                "IPhone 16 Pro Max",
                "7000 ${S.of(context).LYD}",
                "assets/products/smartPhones/iPhone16-Pro-Max-DesertTitanium.webp",
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

Widget productCard(
  BuildContext context,
  String brand,
  String name,
  String price,
  String imagePath,
) {
  return InkWell(
    onTap: () {},
    child: Container(
      width: 250, // Adjust as needed
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.deepOrange[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
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
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(height: 20),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: 20),
                    Text(
                      price,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
