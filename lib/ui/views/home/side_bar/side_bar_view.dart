import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
import 'package:marchant/ui/widgets/setting_item/setting_item.dart';
import 'package:stacked/stacked.dart';

import 'side_bar_viewmodel.dart';

class SideBarView extends StackedView<SideBarViewModel> {
  const SideBarView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SideBarViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: middleSize,
              horizontal: smallSize,
            ),
            child: Column(
              children: [
                ImageBuilder(
                  image: viewModel.image,
                  height: 150,
                ),
                // verticalSpaceSmall,
                const Text('Abebe Kebede', style: AppTextStyle.h3Bold),
                const Text('0912784523', style: AppTextStyle.h4Normal),
                verticalSpaceMiddle,
                const Divider(),
                verticalSpaceMiddle,
                Column(
                  children: viewModel.settingItems.entries
                      .map(
                        (e) => SettingItem(
                          title: e.value.title,
                          icon: e.value.icon,
                          onTap: () => viewModel.onTapHandler(e.key),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          Container(
            color: kcBackgroundColor,
            padding: const EdgeInsets.symmetric(
                vertical: mediumSize, horizontal: middleSize),
            child: SettingItem(
                title: 'Logout',
                icon: FontAwesomeIcons.rightFromBracket,
                forgroundColor: Colors.white,
                onTap: () {}),
          ),
        ],
      ),
    );
  }

  @override
  SideBarViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SideBarViewModel();
}
