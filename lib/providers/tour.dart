import 'package:flutter/material.dart';

class Tour with ChangeNotifier {
  final String id;
  final String title;
  final String location;
  final int price;
  final List<String> imageUrl;

  final List<int> date;
  final List<String> famousResturant;
  final List<String> famousPoints;
  final int duration;
  bool isFav;
  bool isSouth;
  bool isNorth;

  Tour({
    required this.famousResturant,
    required this.famousPoints,
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.date,
    required this.duration,
    this.isNorth = false,
    this.isFav = false,
    this.isSouth = false,
  });

  void toggleFavoriteStatus() {
    isFav = !isFav;
    notifyListeners();
  }
}
