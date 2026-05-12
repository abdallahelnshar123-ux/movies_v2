import 'package:flutter/material.dart';
import 'package:movies/features/ui/home_screen/tabs/browse_tab/browse_tab.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:movies/features/ui/home_screen/tabs/search_tab/search_tab.dart';

class HomeTabProvider extends ChangeNotifier {
  final List<Widget> _tabsList = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];
  int _movieIndex = 0;

  int get carouselIndex => _movieIndex;

  void changeIndex(int index) {
    _movieIndex = index;
    notifyListeners();
  }
}
