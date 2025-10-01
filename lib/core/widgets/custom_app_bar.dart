import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;
  final double? elevation;
  final double? titleSpacing;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final Color? shadowColor;
  final Color? textColor;
  final String? title;

  const CustomAppBar({
    this.automaticallyImplyLeading,
    this.title,
    this.centerTitle,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.textColor,
    this.titleSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? ColorManager.white,
      surfaceTintColor: surfaceTintColor ?? ColorManager.white,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      elevation: elevation ?? 5,
      titleSpacing: 24.w,
      centerTitle: centerTitle,
      shadowColor: shadowColor ?? Colors.black,
      title: Text(
        title ?? '',
        style: getMediumStyle(color: textColor ?? ColorManager.black)
            .copyWith(fontSize: FontSize.s24),
      ),
      actions: centerTitle == false
          ? [Image.asset(ImageAssets.srapIcon, height: 100.h, width: 100.w)]
          : null,
    );
  }

  @override
  Size get preferredSize => Size(0, 65.h);
}
