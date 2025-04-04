import 'package:estore_client/storeMain/domain/entites/get_all_subcategories.dart';
import 'package:estore_client/storeMain/presentation/controllers/categoriesController/get_all_subcategories_bloc.dart';
import 'package:estore_client/storeMain/presentation/controllers/categoriesController/get_all_subcategories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

Widget categoryList(BuildContext context) {
  return BlocBuilder<SubcategoryBloc, SubcategoryState>(
    builder: (context, state) {
      if (state is SubcategoryLoading) {
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
                '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ).redacted(
          context: context,
          redact: true,
          configuration: RedactedConfiguration(
            animationDuration: const Duration(milliseconds: 800),
          ),
        );
      } else if (state is SubcategoryLoaded) {
        return categoriesContainer(state.subcategories, context);
      } else if (state is SubcategoryError) {
        return Center(child: Text(state.message));
      }
      return const Center(child: Text("No data available"));
    },
  );
}

Widget categoryItem(BuildContext context, String imageUrl, String label) {
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
          children: [
            Image.network(
              imageUrl,
              color: Colors.white,
              width: 40,
              height: 40,
              colorBlendMode: BlendMode.srcATop,
            ),
          ],
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

Container categoriesContainer(
  List<GetAllSubCategories> subcategories,
  BuildContext context,
) {
  bool isRTL = Directionality.of(context) == TextDirection.rtl;
  return Container(
    key: Key('categories'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            S.of(context).Categories,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                subcategories.map((subcategory) {
                  return categoryItem(
                    context,
                    subcategory.iconUrl,
                    isRTL ? subcategory.nameAr : subcategory.nameEn,
                  ).redacted(
                    context: context,
                    redact: false,
                    configuration: RedactedConfiguration(
                      animationDuration: const Duration(milliseconds: 800),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    ),
  );
}
