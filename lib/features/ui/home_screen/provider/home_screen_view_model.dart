import 'package:flutter/material.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/view/home_tab.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/view/profile_tab.dart';

import '../tabs/browse_tab/view/browse_tab.dart';
import '../tabs/search_tab/view/search_tab.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final List<Widget> _tabsList = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];
  int _selectedTabIndex = 0;

  Widget get selectedTab => _tabsList[_selectedTabIndex];

  int get selectedTabIndex => _selectedTabIndex;

  void changeIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}
