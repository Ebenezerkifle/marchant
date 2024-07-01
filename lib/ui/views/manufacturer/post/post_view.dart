import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/models/category_model.dart';
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
  const PostView({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      verticalSpaceMiddle,
                      GestureDetector(
                        onTap: viewModel.onPictureAdd,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                      ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: viewModel.name,
                        widget: InputField(
                          validator: (value) => viewModel.validateText(
                            value,
                            viewModel.productNameController,
                            viewModel.name.trim(),
                          ),
                          error: viewModel.formError
                              .containsKey(viewModel.productNameController),
                          controller: viewModel.productNameController,
                          hint: 'Enter product name',
                        ),
                      ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: 'Top Category',
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField<String>(
                              value: viewModel.selectedCategory,
                              hint: const Text('Choose category'),
                              onChanged: viewModel.onCategoryChanged,
                              items: viewModel.topCategories.values
                                  .map((Category category) {
                                return DropdownMenuItem<String>(
                                  value: category.id,
                                  child: Text(category.name ?? ''),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                            if (viewModel.formError.containsKey('category'))
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  viewModel.formError['category']!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      verticalSpaceMiddle,
                      if (viewModel.selectedCategory != null)
                        CustomeFormField(
                          title: 'Sub Category',
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                value: viewModel.selectedSubCategory,
                                hint: const Text('Choose sub category'),
                                onChanged: viewModel.onSubCategoryChanged,
                                items: viewModel.subCategories
                                    .map((Category subCategory) {
                                  return DropdownMenuItem<String>(
                                    value: subCategory.id,
                                    child: Text(subCategory.name ?? ''),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                              if (viewModel.formError
                                  .containsKey('subCategory'))
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    viewModel.formError['subCategory']!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      verticalSpaceMiddle,
                      if (viewModel.selectedSubCategory != null)
                        CustomeFormField(
                          title: 'Sub Sub Category',
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                value: viewModel.selectedSubSubCategory,
                                hint: const Text('Choose sub sub category'),
                                onChanged: viewModel.onSubSubCategoryChanged,
                                items: viewModel.subSubCategories
                                    .map((Category subSubCategory) {
                                  return DropdownMenuItem<String>(
                                    value: subSubCategory.id,
                                    child: Text(subSubCategory.name ?? ''),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                              if (viewModel.formError
                                  .containsKey('subSubCategory'))
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    viewModel.formError['subSubCategory']!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: 'Sales Price',
                        widget: InputField(
                          validator: (value) => viewModel.validateText(
                              value,
                              viewModel.salesPriceController,
                              'Enter sales price'),
                          error: viewModel.formError
                              .containsKey(viewModel.salesPriceController),
                          controller: viewModel.salesPriceController,
                          hint: 'Enter sales price',
                          inputType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        ),
                      ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: 'Description',
                        widget: InputField(
                          validator: (value) => viewModel.validateText(
                              value,
                              viewModel.descriptionController,
                              'Enter description'),
                          error: viewModel.formError
                              .containsKey(viewModel.descriptionController),
                          controller: viewModel.descriptionController,
                          hint: 'Enter description',
                          extendable: true,
                          charLength: 1000,
                          height: 70,
                        ),
                      ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: 'Details',
                        widget: InputField(
                          validator: (value) => viewModel.validateText(
                              value,
                              viewModel.detailsController,
                              'Enter details (comma separated)'),
                          error: viewModel.formError
                              .containsKey(viewModel.detailsController),
                          controller: viewModel.detailsController,
                          hint: 'Enter details (comma separated)',
                          extendable: true,
                          charLength: 1000,
                          height: 50,
                        ),
                      ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: 'Quantity',
                        widget: InputField(
                          validator: (value) => viewModel.validateText(value,
                              viewModel.quantityController, 'Enter quantity'),
                          error: viewModel.formError
                              .containsKey(viewModel.quantityController),
                          controller: viewModel.quantityController,
                          hint: 'Enter quantity',
                          inputType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                      verticalSpaceLarge,
                      if (viewModel.hasError && viewModel.errorMsg.isNotEmpty ||
                          viewModel.formError.isNotEmpty) ...[
                        Text(
                          viewModel.formError.isNotEmpty
                              ? viewModel.formError.entries.first.value
                              : viewModel.errorMsg,
                          style: AppTextStyle.withColor(
                            color: kcDanger,
                            style: AppTextStyle.h4Normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpaceSmall,
                      ],

                      CustomeButton(
                        text: 'Submit',
                        onTap: viewModel.onPostProduct,
                        width: double.infinity,
                        loading: viewModel.isBusy,
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
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











// import 'dart:convert';

// import 'package:http/http.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:marchant/models/category_model.dart';
// import 'package:marchant/ui/common/app_colors.dart';
// import 'package:marchant/ui/common/app_text_style.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/widgets/custome_button.dart';
// import 'package:marchant/ui/views/widgets/custome_form_field.dart';
// import 'package:marchant/ui/views/widgets/input_field.dart';
// import 'package:stacked/stacked.dart';
// import '../../widgets/custome_app_bar.dart';
// import 'post_viewmodel.dart';

// class PostView extends StatelessWidget {
//   const PostView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<PostViewModel>.reactive(
//       viewModelBuilder: () => PostViewModel(),
//       builder: (context, viewModel, child) {
//         return Scaffold(
//           body: SafeArea(
//             top: true,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 CustomeAppBar(title: 'Post a Product', back: false),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Form(
//                       key: viewModel.formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           verticalSpaceMiddle,
//                           // Uploaded images section
//                           if (viewModel.images.isNotEmpty) ...[
//                             SizedBox(
//                               height: 100,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: viewModel.images.length,
//                                 itemBuilder: (context, index) {
//                                   return Row(
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             width: 100,
//                                             height: 100,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               image: DecorationImage(
//                                                 image: NetworkImage(
//                                                   viewModel.images[index],
//                                                 ),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             top: 0,
//                                             right: 0,
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 viewModel.removeImage(index);
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.red,
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                                 child: Icon(
//                                                   Icons.close,
//                                                   color: Colors.white,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(width: 10),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                           // Add pictures section
//                           GestureDetector(
//                             onTap: viewModel.onPictureAdd,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 16.0,
//                               ),
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: kcVeryLightGrey,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     FontAwesomeIcons.plus,
//                                     color: kcPrimaryColor,
//                                   ),
//                                   verticalSpaceSmall,
//                                   Text(
//                                     'Add Pictures',
//                                     style: AppTextStyle.h4Normal,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           verticalSpaceMiddle,
//                           // Other form fields
//                           CustomeFormField(
//                             title: viewModel.name,
//                             widget: InputField(
//                               validator: (value) => viewModel.validateText(
//                                 value,
//                                 viewModel.productNameController,
//                                 viewModel.name.trim(),
//                               ),
//                               error: viewModel.formError
//                                   .containsKey(viewModel.productNameController),
//                               controller: viewModel.productNameController,
//                               hint: 'Enter product name',
//                             ),
//                           ),
//                           // Remaining form fields...
//                           verticalSpaceLarge,
//                           if (viewModel.hasError &&
//                               viewModel.errorMsg.isNotEmpty ||
//                               viewModel.formError.isNotEmpty) ...[
//                             Text(
//                               viewModel.formError.isNotEmpty
//                                   ? viewModel.formError.entries.first.value
//                                   : viewModel.errorMsg,
//                               style: AppTextStyle.withColor(
//                                 color: kcDanger,
//                                 style: AppTextStyle.h4Normal,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             verticalSpaceSmall,
//                           ],
//                           CustomeButton(
//                             text: 'Submit',
//                             onTap: viewModel.onPostProduct,
//                             width: double.infinity,
//                             loading: viewModel.isBusy,
//                           ),
//                           verticalSpaceLarge,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
