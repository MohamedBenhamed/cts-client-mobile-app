import 'package:estore_client/features/home/presentation/widgets/productCard.dart';
import 'package:estore_client/features/home/presentation/widgets/productCardWidget.dart';

import '../../../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

Container popularProductsContainer(BuildContext context) {
  return Container(
    key: Key('popularProducts'),
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
          height: 320, // Fixed height
          width: MediaQuery.of(context).size.width, // Constrained width
          child: ListView(scrollDirection: Axis.horizontal, children: [

            ],
          ),
        ),
      ],
    ),
  );
}
