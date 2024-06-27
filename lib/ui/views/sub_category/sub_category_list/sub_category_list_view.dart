import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/sub_category/sub_category_list/sub_category_list_viewmodel.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
import 'package:stacked/stacked.dart';


// // ignore: must_be_immutable
// class SubCategoryListView extends StackedView<SubCategoryListViewModel> {
//   SubCategoryListView({Key? key, required this.subCategories})
//       : super(key: key);
//   List<Category> subCategories;
//   @override
//   Widget builder(
//     BuildContext context,
//     SubCategoryListViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//         body: SafeArea(
//       top: true,
//       child: Column(children: [
//         CustomeAppBar(title: 'All category'),
//         verticalSpaceMedium,
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: subCategories
//                   .map((e) => Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: middleSize,
//                           //vertical: smallSize,
//                         ),
//                         child: CustomeListTile(
//                           title: e.name ?? "",
//                           noImage: true,
//                           center: true,
//                           onTap: () => viewModel.navigateToSubCategory(e as String),
//                           // dark: viewModel.selected.containsKey(e),
//                           // stackWidget: Positioned(
//                           //     right: smallSize,
//                           //     top: 0,
//                           //     bottom: 0,
//                           //     child: Icon(
//                           //       FontAwesomeIcons.circleDot,
//                           //       color: viewModel.selected.containsKey(e)
//                           //           ? kcWhite
//                           //           : kcPrimaryColorDark,
//                           //     )),
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//         )
//       ]),
//     ));
//   }

//   @override
//   SubCategoryListViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//     SubCategoryListViewModel();
// }





// class SubCategoryListView extends StatelessWidget {
//   final List<Category> subCategories;

//   const SubCategoryListView({Key? key, required this.subCategories}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         top: true,
//         child: Column(
//           children: [
//             CustomeAppBar(title: 'All categories'),
//             verticalSpaceMedium,
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: subCategories
//                       .map((e) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: middleSize),
//                             child: CustomeListTile(
//                               title: e.name ?? '',
//                               noImage: true,
//                               center: true,
//                               onTap: () {
//                                 // viewModel.navigateToSubCategory(e.id); 
//                               },
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






class SubCategoryListView extends StatelessWidget {
  final List<Category> subCategories;

  SubCategoryListView({Key? key, required this.subCategories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubCategoryListViewModel>.reactive(
      viewModelBuilder: () => SubCategoryListViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              CustomeAppBar(title: 'All categories'), // Corrected widget name
              verticalSpaceMedium,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: subCategories
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Assuming `middleSize` is defined elsewhere
                              child: CustomeListTile(
                                title: e.name ?? '',
                                noImage: true,
                                center: true,
                                onTap: () => viewModel.navigateToSubCategory(e.id!), // Fixed onTap function call
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
