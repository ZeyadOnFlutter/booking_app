import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  scaffoldBackgroundColor: ColorManager.lightGrey,
);
