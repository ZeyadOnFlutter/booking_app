import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../auth/presentation/cubit/auth_hydrated_cubit.dart';
import '../../../home/presentation/cubit/booking_cubit.dart';
import '../../../home/presentation/cubit/booking_state.dart';
import '../../../home/presentation/widgets/app_snack_bar.dart';
import '../../../home/presentation/widgets/error_item.dart';
import '../widgets/booking_card.dart';
import '../widgets/bookings_header.dart';

class UserBookingsScreen extends StatelessWidget {
  const UserBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            const BookingsHeader(),
            Expanded(
              child: BlocConsumer<BookingCubit, BookingState>(
                listener: (context, state) {
                  if (state is DeleteBookingLoading) {
                    UIUtils.showLoading(context);
                  } else if (state is DeleteBookingError) {
                    UIUtils.hideLoading(context);
                    AppSnackBar.error(context, state.message);
                  } else if (state is DeleteBookingSuccess) {
                    UIUtils.hideLoading(context);
                    AppSnackBar.success(context, 'Booking cancelled successfully');
                  }
                },
                builder: (context, state) {
                  if (state is GetBookingLoading) {
                    return const Center(
                      child: LoadingIndicator(),
                    );
                  } else if (state is GetBookingError) {
                    return ErrorView(errorMessage: state.message);
                  } else {
                    final bookingCubit = getIt<BookingCubit>();
                    return RefreshIndicator(
                      onRefresh: () async {},
                      color: const Color(0xFF3B82F6),
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: bookingCubit.userBookings?.length ?? 0,
                        itemBuilder: (context, index) {
                          return BookingCard(booking: bookingCubit.userBookings![index]);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
