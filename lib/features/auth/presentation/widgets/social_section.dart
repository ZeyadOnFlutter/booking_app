import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'social_login_options_buttons.dart';
import 'social_login_options_text.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SocialLoginOptionsText(label: 'Or Login With'),
        SizedBox(height: 30.h),
        const SocialLoginOptionsButtons(),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
