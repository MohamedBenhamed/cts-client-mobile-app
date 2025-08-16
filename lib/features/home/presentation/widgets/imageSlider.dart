import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

CarouselSlider imageSlider(context) {
  return CarouselSlider(
    items: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          width: MediaQuery.of(context).size.width * 0.750,
          "assets/sliderImages/image8.png",
          fit: BoxFit.cover,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          width: MediaQuery.of(context).size.width * 0.750,
          "assets/sliderImages/image5.png",
          fit: BoxFit.cover,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          width: MediaQuery.of(context).size.width * 0.750,
          "assets/sliderImages/image7.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ],
    options: CarouselOptions(
      height: 150.0,
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
    ),
  );
}
