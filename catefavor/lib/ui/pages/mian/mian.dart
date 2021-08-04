import 'package:flutter/material.dart';
import 'initialize_items.dart';

class LZMainScreen extends StatefulWidget {
  static const String routeName = "/";
  @override
  _LZMainScreenState createState() => _LZMainScreenState();
}

class _LZMainScreenState extends State<LZMainScreen> {
   int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        unselectedFontSize: 15,
        currentIndex: _currentIndex,
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
