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

  static double screenRatio(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return s.height / s.width;
  }
}
