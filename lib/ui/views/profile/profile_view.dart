import 'package:flutter/material.dart';
import 'package:marchant/models/setting_model.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_text_style.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/setting_item/setting_item.dart';
import '../widgets/image_builder.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({super.key});

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
                      // const Text(
                      //   'Abeniezer Kifle',
                      //   style: AppTextStyle.h2Bold,
                      // ),
                      Text(
                        viewModel.profilePhoneNumber.padLeft(10, '0').toString(),
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
      SettingOptions setting, ProfileViewModel viewModel) {
    switch (setting) {
      case SettingOptions.credit:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            viewModel.credit.toString(),
            style: AppTextStyle.h3Bold.copyWith(color: Colors.white),
          ),
        );
      default:
        return null;
    }
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();
}
