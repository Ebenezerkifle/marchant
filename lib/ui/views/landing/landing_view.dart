import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'landing_viewmodel.dart';
import 'widgets/bottom_nav.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
      viewModelBuilder: () => LandingViewModel(),
      onModelReady: (viewModel) => viewModel.setIndex(0),
      builder: (
        BuildContext context,
        LandingViewModel viewModel,
        Widget? child,
      ) {
        return Scaffold(
          body: IndexedStack(
            index: viewModel.currentIndex,
            children: viewModel.viewsToShow,
          ),
          bottomNavigationBar: BottomNav(
            onTabSelected: (index) => viewModel.setIndex(index),
            currentSelectedIndex: viewModel.currentIndex,
            items: viewModel.itemsToShow,
          ),
        );
      },
    );
  }
}
