import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_text_style.dart';
import '../../common/ui_helpers.dart';
import 'setting_item_model.dart';

class SettingItem extends StackedView<SettingItemModel> {
  const SettingItem({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.onTap,
    this.arrow = false,
    this.forgroundColor,
    this.trailing, // Add the trailing parameter
  });

  final String title;
  final String? description;
  final IconData icon;
  final VoidCallback onTap;
  final bool arrow;
  final Color? forgroundColor;
  final Widget? trailing; // Add the trailing property

  @override
  Widget builder(
      BuildContext context, SettingItemModel viewModel, Widget? child) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: smallSize,
          horizontal: tinySize,
        ),
        width: screenWidth(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: forgroundColor ?? kcDarkGreyColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: forgroundColor != null ? kcDarkGreyColor : kcWhite,
                    size: 18,
                  ),
                ),
                horizontalSpaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppTextStyle.withColor(
                          color: forgroundColor ?? kcDarkGreyColor,
                          style: AppTextStyle.h2Bold,
                        )),
                    if (description != null)
                      Text(description!,
                          style: AppTextStyle.withColor(
                            color: forgroundColor ?? kcDarkGreyColor,
                            style: AppTextStyle.h5Normal,
                          ))
                  ],
                )
              ],
            ),
            if (trailing != null)
              trailing!, // Include trailing widget if it exists
            if (arrow)
              Icon(
                FontAwesomeIcons.angleRight,
                color: forgroundColor ?? kcDarkGreyColor,
              ),
          ],
        ),
      ),
    );
  }

  @override
  SettingItemModel viewModelBuilder(BuildContext context) => SettingItemModel();
}
