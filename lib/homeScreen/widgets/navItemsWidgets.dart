import 'package:flutter/material.dart';

Widget navItem(
  BuildContext context,
  IconData icon,
  String label,
  int index,
  int screenIndex,
  Function(int) onItemTapped,
) {
  return Column(
    children: [
      IconButton(
        icon: Icon(
          icon,
          color:
              screenIndex == index
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
        ),
        onPressed: () => onItemTapped(index),
      ),
      Text(
        label,
        style: TextStyle(
          color:
              screenIndex == index
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
        ),
      ),
    ],
  );
}
