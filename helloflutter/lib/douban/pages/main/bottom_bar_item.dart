import 'package:flutter/material.dart';

class LZBottomBarItem extends BottomNavigationBarItem {
  LZBottomBarItem(String iconName, String title)
      : super(
            title: Text(title),
            icon: Image.asset(
              'images/tabbar/$iconName.png',
              width: 30,
            ),
            activeIcon: Image.asset(
              'images/tabbar/${iconName}_active.png',
              width: 30,
            ));
}
