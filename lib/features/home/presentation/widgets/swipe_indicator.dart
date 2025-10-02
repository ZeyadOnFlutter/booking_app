import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'instruction_item.dart';

class CalendarInstructions extends StatelessWidget {
  const CalendarInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const InstructionItem(
            icon: Icons.swipe_rounded,
            text: 'Swipe to change day',
          ),
          Container(
            width: 1,
            height: 20.h,
            color: const Color(0xFF3B82F6).withOpacity(0.3),
          ),
          const InstructionItem(
            icon: Icons.touch_app_rounded,
            text: 'Tap session to book',
          ),
        ],
      ),
    );
  }
}
