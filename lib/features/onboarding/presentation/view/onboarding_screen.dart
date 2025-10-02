import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/router/route_names.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 100.h),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: [
            PageViewModel(
              title: 'Easy Booking',
              body:
                  'Find and book training sessions in just a few taps. Stay organized with your fitness schedule.',
              image: Center(
                child: SvgPicture.asset(
                  'assets/svg/onboarding1.svg',
                  height: 250.h,
                  width: 250.w, // prevents full width stretching
                  fit: BoxFit.contain,
                ),
              ),
            ),
            PageViewModel(
              title: 'Track Your Progress',
              body:
                  'Stay on top of your workouts and see your progress over time with personalized session tracking.',
              image: Center(
                child: SvgPicture.asset(
                  'assets/svg/onboarding2.svg',
                  height: 250.h,
                  width: 250.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            PageViewModel(
              title: 'Train Anywhere',
              body:
                  'Choose from yoga, HIIT, strength, and more. Join sessions that fit your lifestyle—anytime, anywhere.',
              image: Center(
                child: SvgPicture.asset(
                  'assets/svg/onboarding3.svg',
                  height: 250.h,
                  width: 250.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
          showSkipButton: true,
          skip: _buildButton('Skip'),
          next: _buildIconButton(Icons.arrow_forward),
          done: _buildButton('Get Started'),
          onDone: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('hasSeenOnboarding', true);
            if (context.mounted) {
              context.pushReplacementNamed(RouteNames.login);
            }
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(8.0),
            activeSize: const Size(20.0, 8.0),
            activeColor: ColorManager.blue,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable styled text button
  Widget _buildButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.blue,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  /// Reusable styled icon button
  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: const BoxDecoration(
        color: ColorManager.blue,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20.sp,
      ),
    );
  }
}
