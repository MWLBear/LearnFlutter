import 'package:flutter/material.dart';

import 'initialize_item.dart';
import 'bottom_bar_item.dart';

class LZMainPage extends StatefulWidget {
  const LZMainPage({Key? key}) : super(key: key);

  @override
  _LZMainPageState createState() => _LZMainPageState();
}

class _LZMainPageState extends State<LZMainPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
        items: items,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

