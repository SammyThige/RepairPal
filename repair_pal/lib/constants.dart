import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kCategoryImageSize = 120.0;

class Category {
  String thumbnail;
  String name;
  String description;

  Category(
      {required this.thumbnail, required this.name, required this.description});
}

List<Category> categoryList = [
  Category(
      thumbnail: 'assets/electrician.png',
      name: 'Electrician',
      description: 'Appliances, sockets and lights'),
  Category(
      thumbnail: 'assets/plumber.png',
      name: 'Plumber',
      description: 'KitchenSink, Toilet and Showers'),
  Category(
      thumbnail: 'assets/painter.png',
      name: 'Painter',
      description: 'HousePainting and Wall fence painting'),
  Category(
      thumbnail: 'assets/roofing.png',
      name: 'Roofer',
      description: 'Brick Roof and Mabati'),
  Category(
      thumbnail: 'assets/carpentry.png',
      name: 'Capenty',
      description: 'Door Locks and Furniture'),
  Category(
      thumbnail: 'assets/bricklaying.png',
      name: 'Mason',
      description: 'Structural repair'),
];
