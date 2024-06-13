import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton({
    super.key,
    required this.text,
    required this.onTap,
    this.btnColor = kcDarkGreyColor,
    this.textColor = kcWhite,
    this.height = 50,
    this.width,
    this.stroke = false,
    this.round = true,
    this.stkWidth = 2,
    this.textStyle,
    this.alignment,
    this.icon,
    this.disabled = false,
    this.loading = false,
    this.iconOnly = false,
  });

  final bool stroke;
  final String text;
  final VoidCallback onTap;
  final Color btnColor;
  final Color textColor;
  final double height;
  final double? width;
  final bool round;
  final double stkWidth;
  final TextStyle? textStyle;
  final Widget? icon;
  final MainAxisAlignment? alignment;
  final bool disabled;
  final bool loading;
  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width * .5,
      child: ElevatedButton(
        onPressed: disabled || loading
            ? null
            : () {
                FocusScope.of(context).unfocus();
                onTap();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: stroke
              ? null
              : disabled
                  ? kcMediumGrey
                  : btnColor,
          side: stroke
              ? BorderSide(
                  color: btnColor,
                  width: stkWidth,
                  strokeAlign: BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
          shape: round
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                )
              : const BeveledRectangleBorder(),
        ),
        child: Row(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: [
            if (iconOnly) ...[
              icon ?? Container(),
            ] else ...[
              if (loading)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircularProgressIndicator(
                    color: textColor,
                  ),
                )
              else
                Text(
                  text,
                  style: textStyle ??
                      AppTextStyle.withColor(
                        color: textColor,
                        style: AppTextStyle.h4Normal,
                      ),
                ),
              if (!iconOnly) icon ?? const SizedBox.shrink(),
            ],
          ],
        ),
      ),
    );
  }
}
