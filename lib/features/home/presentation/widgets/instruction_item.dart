import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructionItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InstructionItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xFF3B82F6),
          size: 18.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(
            color: const Color(0xFF3B82F6),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
