import 'package:flutter/material.dart';

import '../../common/app_text_style.dart';
import '../../common/ui_helpers.dart';

class CustomeFormField extends StatelessWidget {
  const CustomeFormField({
    super.key,
    required this.title,
    required this.widget,
    this.space,
  });
  final Widget widget;
  final String title;
  final Widget? space;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.h4Bold,
        ),
        space ?? verticalSpaceSmall,
        widget,
      ],
    );
  }
}
