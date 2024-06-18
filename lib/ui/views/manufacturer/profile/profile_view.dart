import 'package:flutter/material.dart';
import 'package:marchant/models/setting_model.dart';
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
                      const Text(
                        'Abeniezer Kifle',
                        style: AppTextStyle.h2Bold,
                      ),
                      const Text(
                        '0945837261',
                        style: AppTextStyle.h4Normal,
                      ),
                      const Divider(),
                      verticalSpaceMiddle,
                      Column(
                        children: viewModel.settings.entries
                            .map(
                              (e) => SettingItem(
                                title: e.value.title,
                                icon: e.value.icon,
                                trailing: _getTrailingWidget(e.key, viewModel),
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

  Widget? _getTrailingWidget(
      SettingOptions setting, ManuProfileViewModel viewModel) {
    switch (setting) {
      case SettingOptions.shortCode:
        return Text(
          "12345",
          style: AppTextStyle.h3Bold.copyWith(color: Colors.green),
        );
      default:
        return null;
    }
  }

  @override
  ManuProfileViewModel viewModelBuilder(BuildContext context) =>
      ManuProfileViewModel();
}
