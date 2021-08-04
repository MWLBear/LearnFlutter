import 'dart:ui';
import 'package:flutter/material.dart';

class LZSizeFit {
  static late double physicalWidth;
  static late double physicalHeight;
  static late double screenWidth;
  static late double screenHeight;
  static late double dpr;
  static late double statusHeight;

  static late double rpx;
  static late double px;

  static void initialize({double standardSize = 750}) {

    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    dpr = window.devicePixelRatio;
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    statusHeight = window.padding.top / dpr;

    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

  static double setRpx(double size){
    return rpx * size;
  }

  static double setPx(double size){
    return px * size;
  }
}


