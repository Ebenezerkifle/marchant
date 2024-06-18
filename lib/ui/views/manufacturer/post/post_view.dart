// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:marchant/ui/common/app_colors.dart';
// import 'package:marchant/ui/common/app_text_style.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/widgets/custome_button.dart';
// import 'package:marchant/ui/views/widgets/custome_form_field.dart';
// import 'package:marchant/ui/views/widgets/input_field.dart';
// import 'package:stacked/stacked.dart';

// import '../../widgets/custome_app_bar.dart';
// import 'post_viewmodel.dart';

// class PostView extends StackedView<PostViewModel> {
//   const PostView({Key? key}) : super(key: key);

//   @override
//   Widget builder(
//     BuildContext context,
//     PostViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//         body: SafeArea(
//       top: true,
//       child: Column(
//         children: [
//           CustomeAppBar(title: 'Post a Product', back: false),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: middleSize),
//                 child: Column(
//                   children: [
//                     verticalSpaceMiddle,
//                     Container(
//                       //height: screenWidth(context) * .25,
//                       padding: const EdgeInsets.symmetric(vertical: middleSize),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: kcVeryLightGrey,
//                       ),
//                       child: const Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             FontAwesomeIcons.plus,
//                             color: kcPrimaryColor,
//                           ),
//                           verticalSpaceSmall,
//                           Text(
//                             'Add Pictures',
//                             style: AppTextStyle.h4Normal,
//                           )
//                         ],
//                       ),
//                     ),
//                     verticalSpaceMiddle,
//                     CustomeFormField(
//                       title: 'Product title',
//                       widget: InputField(
//                         controller: viewModel.titleController,
//                         hint: viewModel.titleHint,
//                       ),
//                     ),
//                     verticalSpaceMiddle,
//                     CustomeFormField(
//                       title: 'Product description',
//                       widget: InputField(
//                         controller: viewModel.descriptionController,
//                         hint: viewModel.descriptionHint,
//                         extendable: true,
//                         charLength: 1000,
//                         height: 50,
//                       ),
//                     ),
//                     verticalSpaceMiddle,
//                     CustomeFormField(
//                       title: 'Some details',
//                       widget: InputField(
//                         controller: viewModel.detailsController,
//                         hint: viewModel.detailsHint,
//                       ),
//                     ),
//                     verticalSpaceMiddle,
//                     CustomeFormField(
//                       title: 'Price per item',
//                       widget: InputField(
//                         controller: viewModel.priceController,
//                         hint: viewModel.priceHint,
//                       ),
//                     ),
//                     verticalSpaceMiddle,
//                     CustomeFormField(
//                       title: 'Product Category',
//                       widget: InputField(
//                         controller: viewModel.priceController,
//                         hint: viewModel.priceHint,
//                       ),
//                     ),
//                     verticalSpaceLarge,
//                     CustomeButton(
//                       text: 'Submit',
//                       onTap: () {},
//                       width: double.infinity,
//                     ),
//                     verticalSpaceLarge,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }

//   @override
//   PostViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       PostViewModel();
// }





import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/custome_form_field.dart';
import 'package:marchant/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custome_app_bar.dart';
import 'post_viewmodel.dart';

class PostView extends StackedView<PostViewModel> {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PostViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: SafeArea(
      top: true,
      child: Column(
        children: [
          CustomeAppBar(title: 'Post a Product', back: false),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: middleSize),
                child: Column(
                  children: [
                    verticalSpaceMiddle,
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: middleSize),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kcVeryLightGrey,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.plus,
                            color: kcPrimaryColor,
                          ),
                          verticalSpaceSmall,
                          Text(
                            'Add Pictures',
                            style: AppTextStyle.h4Normal,
                          )
                        ],
                      ),
                    ),
                   
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Product Name',
                      widget: InputField(
                        controller: viewModel.productNameController,
                        hint: 'Enter product name',
                      ),
                    ),                    
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Top Category',
                      widget: InputField(
                        controller: viewModel.categoryIdController,
                        hint: 'choose category',
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Sub Category',
                      widget: InputField(
                        controller: viewModel.subCategoryIdController,
                        hint: 'choose sub Category',
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Sub Sub Category',
                      widget: InputField(
                        controller: viewModel.subSubCategoryIdController,
                        hint: 'Choose sub sub category',
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Sales Price',
                      widget: InputField(
                        controller: viewModel.salesPriceController,
                        hint: 'Enter sales price',
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Description',
                      widget: InputField(
                        controller: viewModel.descriptionController,
                        hint: 'Enter description',
                        extendable: true,
                        charLength: 1000,
                        height: 50,
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Details',
                      widget: InputField(
                        controller: viewModel.detailsController,
                        hint: 'Enter details (comma separated)',
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Quantity',
                      widget: InputField(
                        controller: viewModel.quantityController,
                        hint: 'Enter quantity',
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                    verticalSpaceMiddle,
                    
                    CustomeFormField(
                      title: 'Company Name',
                      widget: InputField(
                        controller: viewModel.companyNameController,
                        hint: 'Enter company name',
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Address',
                      widget: InputField(
                        controller: viewModel.addressController,
                        hint: 'Enter address',
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'TIN',
                      widget: InputField(
                        controller: viewModel.tinController,
                        hint: 'Enter TIN',
                      ),
                    ),
                    verticalSpaceLarge,
                    CustomeButton(
                      text: 'Submit',
                      onTap: () {
                        // Handle form submission here
                      },
                      width: double.infinity,
                    ),
                    verticalSpaceLarge,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  PostViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PostViewModel();
}
