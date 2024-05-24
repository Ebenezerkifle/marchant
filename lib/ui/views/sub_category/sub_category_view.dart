// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// import 'sub_category_viewmodel.dart';

// class SubCategoryView extends StatelessWidget {
//   const SubCategoryView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<SubCategoryViewModel>.reactive(
//       viewModelBuilder: () => SubCategoryViewModel(),
//       builder: (context, viewModel, child) => Scaffold(
//         appBar: AppBar(
//           // Add leading icon for back navigation
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: const Text('Sub Category'),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.background,
//         body: Container(
//           padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//           child: const Center(
//             child: Text('Sub Category Page Content'),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:marchant/app/app.locator.dart';


// import 'package:marchant/services/state_service/product_state_service.dart';
//  // Import

// class SubCategoryView extends StatelessWidget {
//   const SubCategoryView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<SubCategoryViewModel>.reactive(
//       viewModelBuilder: () => SubCategoryViewModel(),
//       builder: (context, viewModel, child) => Scaffold(
//         appBar: AppBar(
//           // ... existing AppBar code ...
//         ),
//         backgroundColor: Theme.of(context).colorScheme.background,
//         body: Container(
//           padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//           child: StreamBuilder<Map<String, List<String>>>(
//             stream: locator<ProductStateService>().subCategories,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }

//               if (!snapshot.hasData) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               final subCategories = snapshot.data!;

//               return ListView.builder(
//                 itemCount: subCategories.length,
//                 itemBuilder: (context, index) {
//                   final subCategoryName = subCategories.keys.elementAt(index);
//                   final subCategoryList = subCategories.values.elementAt(index);

//                   return ListTile(
//                     title: Text(subCategoryName),
//                     onTap: () => viewModel.onSubCategorySelected(subCategoryName, subCategoryList.first), // Handle sub category selection
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/category_widget.dart';
import 'package:stacked/stacked.dart';

import 'sub_category_viewmodel.dart';

class SubCategoryView extends StackedView<SubCategoryViewModel> {
  const SubCategoryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SubCategoryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      key: viewModel.scaffoldKey,
      backgroundColor: kcWhite,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(
              title: '${viewModel.selectedCategoryOnHomepage} Category in the home page',
              back: false,
            ),
            verticalSpaceSmall,
            Padding(
              padding: const EdgeInsets.only(left: middleSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...viewModel.selectedCategoryOnHomepage.entries.map((e) => Padding(
                              padding: const EdgeInsets.only(right: tinySize),
                              child: CategoryWidget(
                                name: e.value,
                                selected: viewModel.selected.containsKey(e.key),
                                onTap: () => viewModel.onSelected(e.key),
                              ),
                            )),
                        CategoryWidget(
                          name: 'more',
                          selected: false,
                          onTap: viewModel.onMoreCategory,
                          roundness: 5,
                          hPadding: smallSize,
                          icon: Icon(FontAwesomeIcons.ellipsisVertical),
                        ),
                        horizontalSpaceMiddle,
                      ],
                    ),
                  ),
                  if (viewModel.selected.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: viewModel
                            .subCategories[viewModel.selected.keys.first]!
                            .map((subCategory) => GestureDetector(
                                  onTap: () {
                                    viewModel.onSubCategorySelected(
                                      viewModel.selected.keys.first,
                                      subCategory,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: tinySize, top: smallSize),
                                    child: CategoryWidget(
                                      name: subCategory,
                                      selected: viewModel.selectedSubCategory == subCategory,
                                      onTap: () {},
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: middleSize),
                      child: CustomeGrideWidget(
                        widgets: viewModel.products.entries
                            .map(
                              (e) => CustomeCardWidget(
                                size: screenWidth(context) * .38,
                                onTap: () => viewModel.onItemSelected(e.value),
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
  SubCategoryViewModel viewModelBuilder(BuildContext context) => SubCategoryViewModel();
}
