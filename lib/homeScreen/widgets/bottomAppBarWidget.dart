import 'package:estore_client/auth/shared/authCheck/authCubit.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:estore_client/homeScreen/widgets/navItemsWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BottomAppBar bottomAppBar(
  BuildContext context,
  int screenIndex,
  Function(int) onItemTapped,
) {
  return BottomAppBar(
    height: 95,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: BlocBuilder<AuthCubit, bool?>(
      builder: (context, isLoggedIn) {
        if (isLoggedIn == null) {
          return Center(child: CircularProgressIndicator());
        }

        List<Widget> buttons = [
          navItem(
            context,
            Icons.home_outlined,
            S.of(context).Home,
            0,
            screenIndex,
            onItemTapped,
          ),
          navItem(
            context,
            Icons.search_rounded,
            S.of(context).Search,
            1,
            screenIndex,
            onItemTapped,
          ),
        ];

        if (isLoggedIn) {
          buttons.insertAll(1, [
            navItem(
              context,
              Icons.shopping_cart_outlined,
              S.of(context).Cart,
              2,
              screenIndex,
              onItemTapped,
            ),
            navItem(
              context,
              Icons.shopping_bag_outlined,
              S.of(context).Orders,
              3,
              screenIndex,
              onItemTapped,
            ),
            navItem(
              context,
              Icons.person_outline,
              S.of(context).Account,
              4,
              screenIndex,
              onItemTapped,
            ),
          ]);
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttons,
        );
      },
    ),
  );
}
