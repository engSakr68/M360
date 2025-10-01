import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimens {
  static double cardBorderRadius = 10.w;

  static const double fontSp10 = 10.0;
  static const double fontSp12 = 12.0;
  static const double fontSp14 = 14.0;
  static const double fontSp15 = 15.0;
  static const double fontSp16 = 16.0;
  static const double fontSp18 = 18.0;
  static const double fontSp20 = 20.0;
  static const double fontSp22 = 22.0;
  static const double fontSp24 = 24.0;
  static const double fontSp26 = 26.0;
  static const double fontSp28 = 28.0;
  static const double fontSp30 = 30.0;
  static const double fontSp32 = 32.0;
  static const double fontSp38 = 38.0;

  static const double dp1 = 1;
  static const double dp2 = 2;
  static const double dp3 = 3;
  static const double dp4 = 4;
  static const double dp6 = 6;
  static const double dp5 = 5;
  static const double dp7 = 7;
  static const double dp8 = 8;
  static const double dp10 = 10;
  static const double dp12 = 12;
  static const double dp13 = 13;
  static const double dp14 = 14;
  static const double dp15 = 15;
  static const double dp16 = 16;
  static const double dp18 = 18;
  static const double dp20 = 20;
  static const double dp22 = 22;
  static const double dp24 = 24;
  static const double dp26 = 26;
  static const double dp28 = 28;
  static const double dp30 = 30;
  static const double dp32 = 32;
  static const double dp49 = 49;
  static const double dp50 = 50;
  static const double dp64 = 64;
  static const double dp96 = 96;
  static const double dp128 = 128;
  static const double dp256 = 256;

  static const double appBarHeight = 62;
  static const double searchBarHeight = 56;

  static const BorderRadius sheetBorderRadius = BorderRadius.vertical(top: Radius.circular(20));
  static const BorderRadius borderRadius5PX = BorderRadius.all(Radius.circular(10));

  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
