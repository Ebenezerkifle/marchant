import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';

class IconDecoreWidget extends StatelessWidget {
  const IconDecoreWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.circle = false,
    this.forgroundColor = kcPrimaryColorDark,
    this.backgroundColor = kcLightGrey,
    this.iconSize = 25,
    this.widget = false,
    this.myIcon,
    this.roundness = 15,
  });
  final IconData icon;
  final VoidCallback onTap;
  final bool circle;
  final Color forgroundColor;
  final Color backgroundColor;
  final double iconSize;
  final bool widget;
  final Widget? myIcon;
  final double roundness;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(smallSize),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: !circle ? BorderRadius.circular(roundness) : null,
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: widget
            ? SizedBox(
                height: iconSize,
                width: iconSize,
                child: myIcon ?? Container(),
              )
            : Icon(
                icon,
                size: iconSize,
                color: forgroundColor,
              ),
      ),
    );
  }
}
