import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? statusColor;

  const BookingInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: const Color(0xFF6F767E),
        ),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF6F767E),
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: statusColor ?? const Color(0xFF1A1D1F),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
