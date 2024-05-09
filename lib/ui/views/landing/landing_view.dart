import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'landing_viewmodel.dart';
import 'widgets/bottom_nav.dart';

class LandingView extends StackedView<LandingViewModel> {
  const LandingView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LandingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: IndexedStack(
          index: viewModel.currentIndex,
          children: viewModel.retailor
              ? viewModel.marchantViews
              : viewModel.manufacturorViews,
        ),
        bottomNavigationBar: BottomNav(
          onTabSelected: (index) => viewModel.setIndex(index),
          currentSelectedIndex: viewModel.currentIndex,
          items: viewModel.retailor
              ? viewModel.marchantItems
              : viewModel.manufacturorerItems,
        ));
  }

  @override
  LandingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LandingViewModel();
}
