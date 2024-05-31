import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: viewModel.allCategories.entries
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: middleSize,
                          //vertical: smallSize,
                        ),
                        child: CustomeListTile(
                          title: e.value.name ?? "",
                          noImage: true,
                          center: true,
                          onTap: () => viewModel.onSelected(e.key),
                          dark: viewModel.selected.containsKey(e.key),
                          stackWidget: Positioned(
                              right: smallSize,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                FontAwesomeIcons.circleDot,
                                color: viewModel.selected.containsKey(e.key)
                                    ? kcWhite
                                    : kcPrimaryColorDark,
                              )),
                        ),
                      ))
                  .toList(),
            ),
          ),
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
