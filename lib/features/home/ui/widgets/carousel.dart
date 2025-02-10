



import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';

Widget carousel(List<Widget> items){
  return CarouselSlider(
  items: items,
  options: CarouselOptions(
    height: 150,
    aspectRatio: 16/9,
    viewportFraction: 0.8,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: true,
    enlargeFactor: 0.3,
    scrollDirection: Axis.horizontal,
  )
);
}