import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../core/router/route_names.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: 'Easy Booking',
            body:
                'Find and book training sessions in just a few taps. Stay organized with your fitness schedule.',
            image: SvgPicture.asset(
              'assets/svg/onboarding1.svg',
              height: 250.h,
            ),
          ),
          PageViewModel(
            title: 'Track Your Progress',
            body:
                'Stay on top of your workouts and see your progress over time with personalized session tracking.',
            image: SvgPicture.asset(
              'assets/svg/onboarding3.svg',
              height: 250.h,
            ),
          ),
          PageViewModel(
            title: 'Train Anywhere',
            body:
                'Choose from yoga, HIIT, strength, and more. Join sessions that fit your lifestyle—anytime, anywhere.',
            image: SvgPicture.asset(
              'assets/svg/onboarding3.svg',
              height: 250.h,
            ),
          ),
        ],
        showSkipButton: true,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Get Started',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onDone: () {
          context.pushReplacementNamed(RouteNames.login);
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(8.0),
          activeSize: const Size(16.0, 8.0),
          activeColor: Colors.blueAccent,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
