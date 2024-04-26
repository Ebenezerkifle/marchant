import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:stacked/stacked.dart';

import 'category_list_viewmodel.dart';

class CategoryListView extends StackedView<CategoryListViewModel> {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CategoryListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: SafeArea(
      top: true,
      child: Column(children: [
        CustomeAppBar(title: 'All category'),
        verticalSpaceMedium,
        Column(
          children: viewModel.allCategories.entries
              .map((e) => Text(
                    e.value,
                    style: AppTextStyle.h3Normal,
                  ))
              .toList(),
        )
      ]),
    ));
  }

  @override
  CategoryListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoryListViewModel();
}
