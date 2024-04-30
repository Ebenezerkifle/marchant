import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/home/side_bar/side_bar_drawer.dart';
import 'package:marchant/ui/views/widgets/category_widget.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/search_widget.dart';
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
      backgroundColor: kcWhite,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: mediumSize),
            child: GestureDetector(
              onTap: viewModel.onCartTap,
              child: const Icon(
                FontAwesomeIcons.cartShopping,
                color: kcPrimaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: middleSize),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                FontAwesomeIcons.solidBell,
                color: kcPrimaryColor,
              ),
            ),
          )
        ],
      ),
      drawer: sideBarDrawer(context),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: middleSize,
                vertical: middleSize,
              ),
              child: SearchWidget(),
            ),
            verticalSpaceSmall,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: middleSize),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: viewModel.topCategory.entries
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.only(right: smallSize),
                                child: CategoryWidget(
                                  name: e.value,
                                  selected:
                                      viewModel.selected.containsKey(e.key),
                                  onTap: () => viewModel.onSelected(e.key),
                                ),
                              ))
                          .toList(),
                    ),
                    CategoryWidget(
                      name: 'more',
                      selected: true,
                      onTap: viewModel.onMoreCategory,
                      roundness: 5,
                      hPadding: smallSize,
                      icon: const Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: kcWhite,
                      ),
                    ),
                    horizontalSpaceMiddle,
                  ],
                ),
              ),
            ),
            verticalSpaceMedium,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: middleSize),
                      child: CustomeGrideWidget(
                        widgets: viewModel.products.entries
                            .map(
                              (e) => CustomeCardWidget(
                                size: screenWidth(context) * .38,
                                onTap: () => viewModel.onItemSelecte(e.value),
                                title: e.value.title ?? '',
                                details: e.value.details ?? [],
                                detailLimit: 3,
                                image: e.value.images?.first ?? '',
                                widget: Text(
                                  '${e.value.price} ETB',
                                  style: AppTextStyle.h4Bold,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    verticalSpaceLarge,
                  ],
                ),
              ),
            ),
            verticalSpaceSmall,
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
