import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UiUtils {
  static double adaptableWidth(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (!kIsWeb) return s.width;
    double r = s.width / s.height;
    double width;
    double minWidth = 300;
    if(r > 2)
      return 400;
    width = minWidth + 100 * (r - 1.0);
    return max(width, minWidth);
  }

  static double adaptableTopPadding() => kIsWeb ? 32.0 : 0.0;

  static bool isMobile(BuildContext context) {
    double r = screenRatio(context);
    if( r < 1.0 && MediaQuery.of(context).size.width < 735)
      return true;
    return r > 0.8;
  }

  static double authTitlefontSize(BuildContext context){
    return 12.0 + 20.0*(MediaQuery.of(context).size.height/800);
  }

  static double screenRatio(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return s.height / s.width;
  }

  static bool showDetails(BuildContext context){
    return MediaQuery.of(context).size.width > 800;
  }

  static bool showDetailsSmall(BuildContext context){
    return MediaQuery.of(context).size.width < 950;
  }

  static int tabBarFlex(BuildContext context){
    double w = MediaQuery.of(context).size.width;
    if(w > 700)
      return 7;
    if( w < 500)
      return 20;
    return 20;
  }

  static double textfieldWidth(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    if(width < 600)
      return 200;
    if(showDetails(context) && width < 1100)
      return 200;
    return  250;
  }
}
