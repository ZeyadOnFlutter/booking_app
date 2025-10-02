import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/widgets/social_circle_button.dart';
import '../cubit/auth_hydrated_cubit.dart';

class SocialLoginOptionsButtons extends StatelessWidget {
  const SocialLoginOptionsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Facebook Button

        SocialCircleButton(
          assetPath: SvgAssets.facebook,
          backgroundColor: Colors.white,
          onTap: _onFacebookPressed,
        ),

        SizedBox(width: 20.w),

        SocialCircleButton(
          assetPath: SvgAssets.google,
          backgroundColor: Colors.white,
          onTap: _onGooglePressed,
        ),
      ],
    );
  }

  void _onFacebookPressed() {
    final authCubit = getIt<AuthCubit>();
    authCubit.signInWithFacebook();
  }

  void _onGooglePressed() {
    final authCubit = getIt<AuthCubit>();
    authCubit.signInWithGoogle();
  }
}
