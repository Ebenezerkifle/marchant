import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
import 'package:stacked/stacked.dart';

import 'choose_catagory_viewmodel.dart';

class ChooseCatagoryView extends StackedView<ChooseCatagoryViewModel> {
  const ChooseCatagoryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChooseCatagoryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: largeSize * 3,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    color: kcPrimaryColorDark,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kcWhite,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Column(
                    children: [
                      verticalSpaceLarge,
                      Text(
                        'Choose the business catagory \nyou are involved on',
                        style: AppTextStyle.h2Bold,
                        textAlign: TextAlign.center,
                      ),
                      verticalSpaceMiddle,
                    ],
                  ),
                ),
              ],
            ),
            verticalSpaceMiddle,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    children: [
                      verticalSpaceMiddle,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: viewModel.catagories.entries
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: middleSize),
                                  child: CustomeListTile(
                                    title: e.value,
                                    noPrice: true,
                                    onTap: () => viewModel.onSelected(e.key),
                                    height: 80,
                                    center: true,
                                    selected:
                                        viewModel.selected.containsKey(e.key),
                                    stackWidget: Positioned(
                                      top: 40,
                                      right: smallSize,
                                      child: Icon(
                                        viewModel.selected.containsKey(e.key)
                                            ? FontAwesomeIcons.solidCircleDot
                                            : FontAwesomeIcons.circleDot,
                                        color: kcPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: middleSize,
          vertical: smallSize,
        ),
        child: CustomeButton(text: 'Submit', onTap: viewModel.onSubmit),
      ),
    );
  }

  @override
  ChooseCatagoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChooseCatagoryViewModel();
}
