import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/color_manager.dart'; // adjust path if needed
import '../../../home/presentation/cubit/booking_cubit.dart';
import '../../../home/presentation/cubit/booking_state.dart';

class BookingsHeaderTitle extends StatelessWidget {
  const BookingsHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back,
            color: ColorManager.blue,
            size: 30.r,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Bookings',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1D1F),
              ),
            ),
            SizedBox(height: 4.h),
            BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                final activeBookings = context.read<BookingCubit>().userBookings!.length;
                return Text(
                  '$activeBookings ${activeBookings == 1 ? 'session' : 'sessions'}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF6F767E),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
