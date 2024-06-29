// import 'package:flutter/material.dart';
// import 'package:marchant/ui/common/app_colors.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
// import 'package:marchant/ui/views/widgets/custome_button.dart';
// import 'package:marchant/ui/views/widgets/nothing_found.dart';
// import 'package:stacked/stacked.dart';

// import '../../../common/app_text_style.dart';
// import '../../widgets/custome_card_widget.dart';
// import '../../widgets/custome_grid_widget.dart';
// import 'manu_home_viewmodel.dart';

// class ManuHomeView extends StackedView<ManuHomeViewModel> {
//   const ManuHomeView({super.key});

//   @override
//   Widget builder(
//     BuildContext context,
//     ManuHomeViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//         body: SafeArea(
//       top: true,
//       child: Column(
//         children: [
//           CustomeAppBar(
//             title: 'Merchant',
//             back: false,
//             phoneIcon: Icons.phone,
//             phoneNumber: '889',
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               key: viewModel.refreshIndicatorKey,
//               displacement: 50,
//               color: Colors.white,
//               backgroundColor: kcPrimaryColor,
//               onRefresh: viewModel.refresh,
//               child: viewModel.products.isNotEmpty
//                   ? SingleChildScrollView(
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: middleSize),
//                         child: Column(
//                           children: [
//                             verticalSpaceMedium,
//                             // Our Products Section Title
//                             const Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text('Your Products',
//                                     style: AppTextStyle.h2Bold),
//                               ],
//                             ),

//                             viewModel.isBusy
//                                 ? SizedBox(
//                                     height: screenHeight(context) * .4,
//                                     width: double.infinity,
//                                     child: const Center(
//                                         child: CircularProgressIndicator()),
//                                   )
//                                 : viewModel.products.isEmpty &&
//                                         !viewModel.isBusy
//                                     ? SizedBox(
//                                         height: screenHeight(context) * .4,
//                                         width: double.infinity,
//                                         child: const Center(
//                                           child: Text(
//                                             'No products found',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : CustomeGrideWidget(
//                                         widgets: viewModel.products.entries
//                                             .map(
//                                               (e) => CustomeCardWidget(
//                                                 size:
//                                                     screenWidth(context) * .38,
//                                                 onTap: () =>
//                                                     viewModel.onItemSelected(e
//                                                         .value), // => viewModel.onItemSelected(e.value),
//                                                 title:
//                                                     e.value.productName ?? '',
//                                                 details: e.value.details ?? [],
//                                                 detailLimit: 3,
//                                                 image:
//                                                     e.value.productImage.first,
//                                                 widget: Text(
//                                                   '${e.value.salesPrice} ETB',
//                                                   style: AppTextStyle.h4Bold,
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                       ),
//                             verticalSpaceLarge,
//                           ],
//                         ),
//                       ),
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         NothingFound(
//                           message: 'You have no product which is live.',
//                           child: CustomeButton(
//                             text: 'Post Product',
//                             onTap: viewModel.onPostProduct,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }

//   @override
//   ManuHomeViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       ManuHomeViewModel();
// }


import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_text_style.dart';
import '../../widgets/custome_card_widget.dart';
import '../../widgets/custome_grid_widget.dart';
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
      key: viewModel.scaffoldKey,
      backgroundColor: kcWhite,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(
              title: 'Merchant',
              back: false,
              phoneIcon: Icons.phone,
              phoneNumber: '889',
            ),
            Expanded(
              child: RefreshIndicator(
                key: viewModel.refreshIndicatorKey,
                displacement: 50,
                color: Colors.white,
                backgroundColor: kcPrimaryColor,
                onRefresh: viewModel.refresh,
                child: viewModel.isBusy
                    ? SizedBox(
                        height: screenHeight(context) * .4,
                        width: double.infinity,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : viewModel.errorMessage != null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  viewModel.errorMessage!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(height: 20),
                                CustomeButton(
                                  text: 'Retry',
                                  onTap: viewModel.refresh,
                                ),
                              ],
                            ),
                          )
                        : viewModel.products.isNotEmpty
                            ? SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                                  child: Column(
                                    children: [
                                      verticalSpaceMedium,
                                      // Our Products Section Title
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Your Products', style: AppTextStyle.h2Bold),
                                        ],
                                      ),
                                      CustomeGrideWidget(
                                        widgets: viewModel.products.entries
                                            .map(
                                              (e) => CustomeCardWidget(
                                                size: screenWidth(context) * .38,
                                                onTap: () => viewModel.onItemSelected(e.value),
                                                title: e.value.productName ?? '',
                                                details: e.value.details ?? [],
                                                detailLimit: 3,
                                                image: e.value.productImage.first,
                                                widget: Text(
                                                  '${e.value.salesPrice} ETB',
                                                  style: AppTextStyle.h4Bold,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      verticalSpaceLarge,
                                    ],
                                  ),
                                ),
                              )
                            : Column(
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  ManuHomeViewModel viewModelBuilder(BuildContext context) => ManuHomeViewModel();
}
