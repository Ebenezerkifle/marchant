import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'change_paswords_viewmodel.dart';

class ChangePaswordsView extends StackedView<ChangePaswordsViewModel> {
  const ChangePaswordsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChangePaswordsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  ChangePaswordsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChangePaswordsViewModel();
}
