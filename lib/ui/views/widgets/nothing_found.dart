import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key, this.message, this.image});
  final String? message;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ImageBuilder(
        //   image: image ?? 'assets/images/empty_cart.png',
        //   height: screenWidth(context),
        // ),

        Icon(
          FontAwesomeIcons.searchengin,
          size: screenWidthFraction(context, dividedBy: 4),
          color: kcLightGrey,
        ),
        verticalSpaceSmall,
        Text(
          message ?? 'Nothing found!',
          style: AppTextStyle.h4Normal,
        )
      ],
    );
  }
}
