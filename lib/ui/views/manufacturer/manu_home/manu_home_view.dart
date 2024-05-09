import 'package:flutter/material.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:stacked/stacked.dart';

import 'manu_home_viewmodel.dart';

class ManuHomeView extends StackedView<ManuHomeViewModel> {
  const ManuHomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ManuHomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: SafeArea(
      top: true,
      child: Column(
        children: [
          CustomeAppBar(title: 'Marchant', back: false),
        ],
      ),
    ));
  }

  @override
  ManuHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManuHomeViewModel();
}
