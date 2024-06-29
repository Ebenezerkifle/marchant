import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
import 'package:marchant/ui/widgets/setting_item/setting_item.dart';
import 'package:stacked/stacked.dart';
import 'profile_viewmodel.dart';

class ManuProfileView extends StackedView<ManuProfileViewModel> {
  const ManuProfileView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ManuProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: mediumSize, horizontal: middleSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: AppTextStyle.h1Bold,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    children: [
                      ImageBuilder(
                        image: viewModel.image,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      verticalSpaceSmall,
                      // const Text(
                      //   'Abeniezer Kifle',
                      //   style: AppTextStyle.h2Bold,
                      // ),
                      Text(
                        viewModel.profilePhoneNumber
                            .padLeft(10, '0')
                            .toString(),
                        style: AppTextStyle.h4Bold,
                      ),
                      const Divider(),
                      verticalSpaceMiddle,
                      Column(
                        children: viewModel.settings.entries
                            .map(
                              (e) => SettingItem(
                                title: e.value.title,
                                icon: e.value.icon,
                                onTap: () => viewModel.tapHandler(e.key),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  ManuProfileViewModel viewModelBuilder(BuildContext context) =>
      ManuProfileViewModel();
}
