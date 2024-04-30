import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: middleSize,
          horizontal: smallSize,
        ),
        child: Column(
          children: [
            Column(
              children: [
                ImageBuilder(
                  image: viewModel.image,
                  height: 150,
                ),
                // verticalSpaceSmall,
                const Text('Abebe Kebede', style: AppTextStyle.h3Bold),
                const Text('0912784523', style: AppTextStyle.h4Normal),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  SideBarViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SideBarViewModel();
}
