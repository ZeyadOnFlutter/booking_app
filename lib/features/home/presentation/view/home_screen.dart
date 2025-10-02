import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../auth/presentation/cubit/auth_hydrated_cubit.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/session_cubit.dart';
import '../cubit/session_state.dart';
import '../widgets/calendar_item.dart';
import '../widgets/error_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bookingCubit = getIt<BookingCubit>();
  final authCubit = getIt<AuthCubit>();
  final sessionCubit = getIt<SessionCubit>();
  @override
  void initState() {
    super.initState();
    bookingCubit.getBookings(authCubit.currentUser!.id);
    sessionCubit.getSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          if (state is SessionLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is SessionError) {
            return ErrorView(errorMessage: state.errorMessage);
          } else if (state is SessionSuccess) {
            return CalendarWidget(sessions: state.sessions);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
