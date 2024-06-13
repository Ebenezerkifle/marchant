import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_text_style.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/setting_item/setting_item.dart';
import '../widgets/image_builder.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
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
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
