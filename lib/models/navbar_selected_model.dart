import 'package:flutter/material.dart';

import '../pages/explore.dart';
import '../pages/favorites.dart';
import '../pages/home.dart';
import '../pages/messages.dart';


class NavbarTabSelectedModel extends ChangeNotifier {
  int _currentTab = 0;
  List <Widget> _pages = [
    HomePage(),
    Explore(),
    Favorites(),
    Messages(),
  ];

  set currentTab(int tab) { this._currentTab = tab; notifyListeners();}
  get currentTab => this._currentTab;
  get currentScreen => this._pages[this._currentTab];
}