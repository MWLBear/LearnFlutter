import 'package:catefavor/ui/pages/home/home_drawer.dart';

import 'home_app_bar.dart';
import 'package:flutter/material.dart';
import 'home_content.dart';

class LZHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LZHomeAppBar(context),
      body: LZHomeContent(),
    );
  }
}
