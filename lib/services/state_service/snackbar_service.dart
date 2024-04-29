import 'package:flutter/material.dart';

import '../../ui/common/app_colors.dart';
import '../../ui/common/app_text_style.dart';
import '../../ui/common/ui_helpers.dart';

class SnackBarService {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  static void showSnackBar({required String content}) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.symmetric(
          vertical: middleSize,
          horizontal: smallSize,
        ),
        // margin: const EdgeInsets.symmetric(
        //   vertical: middleSize,
        //   horizontal: smallSize,
        // ),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        // elevation: 8.0,
        backgroundColor: kcPrimaryColor,
        content: Text(
          content,
          style: AppTextStyle.withColor(
            color: kcWhite,
            style: AppTextStyle.h4Normal,
          ),
        ),
      ),
    );
  }
}
