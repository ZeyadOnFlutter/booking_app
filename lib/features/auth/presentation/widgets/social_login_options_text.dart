import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class SocialLoginOptionsText extends StatelessWidget {
  const SocialLoginOptionsText({super.key, this.label});
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDivider(),
        Text(
          label ?? '',
          style: getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    return Expanded(
      child: Divider(
        color: ColorManager.grey2,
        thickness: 1,
        indent: 20.w,
        endIndent: 20.w,
      ),
    );
  }
}
