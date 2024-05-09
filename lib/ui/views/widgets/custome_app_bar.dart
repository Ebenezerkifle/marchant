import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_text_style.dart';

class CustomeAppBar extends StatelessWidget {
  CustomeAppBar({
    super.key,
    required this.title,
    this.bgColor = kcWhite,
    this.textColor = kcPrimaryColorDark,
    this.onBack,
    this.back = true,
    this.textStyle,
    this.widget,
    this.leading,
  });
  final String title;
  final Color bgColor;
  final Color textColor;
  final VoidCallback? onBack;
  final bool back;
  final TextStyle? textStyle;
  final Widget? widget;
  final Widget? leading;

  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .08,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: middleSize,
      ),
      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            leading ?? Container(),
            if (back) ...[
              GestureDetector(
                onTap: onBack ?? () => _navigationService.back(),
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: textColor,
                ),
              ),
              horizontalSpaceMiddle,
            ],
            Text(
              title,
              style: textStyle ??
                  AppTextStyle.withColor(
                    color: textColor,
                    style: AppTextStyle.h1Bold,
                  ),
            )
          ]),
          widget ?? Container(),
        ],
      ),
    );
  }
}
