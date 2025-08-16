import 'package:estore_client/features/home/domain/entites/get_all_subcategories.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_bloc.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_states.dart';
import 'package:estore_client/features/navigationMain/HomeScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

Widget categoryList(BuildContext context) {
  return BlocBuilder<SubcategoryBloc, SubcategoryState>(
    builder: (context, state) {
      if (state is SubcategoryLoading) {
        return loadingAndErrorCategories();
      } else if (state is SubcategoryLoaded) {
        return categoriesContainer(state.subcategories, context);
      } else if (state is SubcategoryError) {
        return loadingAndErrorCategories();
      }
      return const Center(child: Text("No data available"));
    },
  );
}

// ignore: camel_case_types
class loadingAndErrorCategories extends StatelessWidget {
  const loadingAndErrorCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).Categories,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centers icon
                      children: [],
                    ),
                  ),
                  SizedBox(
                    width: 150,
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
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centers icon
                      children: [],
                    ),
                  ),
                  SizedBox(
                    width: 150,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget categoryItem(BuildContext context, String imageUrl, String label) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
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
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => NavigationMainScreen(
                                initialIndex: 1,
                                parameter: subcategory.id,
                              ),
                        ),
                      );
                    },
                    child: categoryItem(
                      context,
                      subcategory.iconUrl,
                      isRTL ? subcategory.nameAr : subcategory.nameEn,
                    ).redacted(
                      context: context,
                      redact: false,
                      configuration: RedactedConfiguration(
                        animationDuration: const Duration(milliseconds: 800),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    ),
  );
}
