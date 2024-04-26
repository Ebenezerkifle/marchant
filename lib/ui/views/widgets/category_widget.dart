import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';

import '../../common/app_text_style.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.name,
    required this.selected,
    required this.onTap,
    this.icon,
    this.color,
    this.txtColor,
    this.textStyle,
    this.roundness,
    this.hPadding,
    this.vPadding,
  });
  final String name;
  final bool selected;
  final VoidCallback onTap;
  final Widget? icon;
  final Color? color;
  final Color? txtColor;
  final TextStyle? textStyle;
  final double? roundness;
  final double? hPadding;
  final double? vPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? mediumSize,
          vertical: vPadding ?? smallSize,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: color ?? kcPrimaryColorDark,
            width: selected ? 0 : 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(roundness ?? 25),
          ),
          color: selected ? color ?? kcPrimaryColorDark : kcWhite,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: textStyle ??
                  AppTextStyle.withColor(
                    color:
                        txtColor ?? (selected ? kcWhite : kcPrimaryColorDark),
                    style: AppTextStyle.h4Normal,
                  ),
            ),
            if (icon != null) ...[
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
