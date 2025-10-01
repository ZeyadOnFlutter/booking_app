import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/loading_indicator.dart';

class UIUtils {
  static void showLoading(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: SizedBox(
              height: 50.h,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingIndicator(),
                ],
              ),
            ),
          ),
        ),
      );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
      );
}
