import 'package:flutter/material.dart';

class HomeTabProvider extends ChangeNotifier {
  int _carouselIndex = 0;

  int get carouselIndex => _carouselIndex;

  void changeCarouselIndex(int index) {
    _carouselIndex = index;
    notifyListeners();
  }
}
