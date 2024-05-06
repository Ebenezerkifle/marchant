import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key, this.message, this.image});
  final String? message;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ImageBuilder(
            image: image ?? 'assets/images/empty_cart.png',
            height: screenWidth(context),
          ),
          verticalSpaceSmall,
          Text(
            message ?? 'Nothing found!',
            style: AppTextStyle.h3Normal,
          )
        ],
      ),
    );
  }
}
