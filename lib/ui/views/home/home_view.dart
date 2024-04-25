import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      key: viewModel.scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => viewModel.scaffoldKey.currentState!.openDrawer(),
            child: const Icon(
              FontAwesomeIcons.bars,
            )),
        title: const Text(
          'Marchant',
          style: AppTextStyle.big,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: middleSize),
            child: Icon(
              FontAwesomeIcons.solidBell,
              color: kcPrimaryColor,
            ),
          )
        ],
      ),
      drawer: Drawer(
        width: screenWidth(context) * .7,
        backgroundColor: kcPrimaryColorDark,
        child: Column(),
      ),
      body: const SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: middleSize, horizontal: middleSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
