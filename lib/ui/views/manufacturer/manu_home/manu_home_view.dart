import 'package:flutter/material.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
import 'package:stacked/stacked.dart';

import 'manu_home_viewmodel.dart';

class ManuHomeView extends StackedView<ManuHomeViewModel> {
  const ManuHomeView({super.key});

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
          CustomeAppBar(
            title: 'Marchant',
            back: false,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NothingFound(
                  message: 'You have no product which is live.',
                  child: CustomeButton(
                    text: 'Post Product',
                    onTap: viewModel.onPostProduct,
                  ),
                ),
              ],
            ),
          ),
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
