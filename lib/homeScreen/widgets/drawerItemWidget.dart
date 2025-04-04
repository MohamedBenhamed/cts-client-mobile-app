import 'package:flutter/material.dart';

Widget drawerItem(
  IconData icon,
  String title,
  GestureTapCallback onTap, {
  Color color = Colors.white,
}) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(title, style: TextStyle(color: color, fontSize: 18)),
    onTap: onTap,
  );
}
