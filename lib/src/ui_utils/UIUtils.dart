
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UiUtils{
  static double adaptableWidth(BuildContext context){
    Size s = MediaQuery.of(context).size;
    if(!kIsWeb)
      return s.width;
    double r = s.width/s.height;
    double width;
    double minWidth = 300;
    width = minWidth + 100*(r - 1.0);
    return max(width, minWidth);
  }
  static double adaptableTopPadding() => kIsWeb? 32.0 : 0.0;
}