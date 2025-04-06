import '../../../../../generated/l10n.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.menu),
      iconSize: 30,
      color: Theme.of(context).primaryColor,
    ),
    // backgroundColor: Color(0xFF1E1E1E),
    title: Text(
      S.of(context).AppTitle,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.notifications_outlined),
        iconSize: 30,
        color: Theme.of(context).primaryColor,
      ),
    ],
  );
}
