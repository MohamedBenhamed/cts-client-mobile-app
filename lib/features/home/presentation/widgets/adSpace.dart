import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget adBanner(BuildContext context, String ImageStr) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        ImageStr,
        width: MediaQuery.of(context).size.width * 1,
        height: 190,
        fit: BoxFit.cover,
      ),
    ),
  );
}
