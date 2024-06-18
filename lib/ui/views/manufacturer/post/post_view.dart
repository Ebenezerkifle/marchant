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

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      viewModelBuilder: () => PostViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              CustomeAppBar(title: 'Post a Product', back: false),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        verticalSpaceMiddle,
                        Container(
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
                          widget: DropdownButtonFormField<String>(
                            value: viewModel.selectedCategory,
                            hint: const Text('Choose category'),
                            onChanged: viewModel.onCategoryChanged,
                            items: viewModel.topCategories.keys
                                .map((String key) {
                                  return DropdownMenuItem<String>(
                                    value: key,
                                    child: Text(viewModel.topCategories[key]?.name ?? ''),
                                  );
                                })
                                .toList(),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                        verticalSpaceMiddle,
                        if (viewModel.selectedCategory != null)
                          CustomeFormField(
                            title: 'Sub Category',
                            widget: DropdownButtonFormField<String>(
                              value: viewModel.selectedSubCategory,
                              hint: const Text('Choose sub category'),
                              onChanged: viewModel.onSubCategoryChanged,
                              items: viewModel.subCategories
                                  .map((String subCategory) {
                                    return DropdownMenuItem<String>(
                                      value: subCategory,
                                      child: Text(subCategory),
                                    );
                                  })
                                  .toList(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ),
                        verticalSpaceMiddle,
                        if (viewModel.selectedSubCategory != null)
                          CustomeFormField(
                            title: 'Sub Sub Category',
                            widget: DropdownButtonFormField<String>(
                              value: viewModel.selectedSubSubCategory,
                              hint: const Text('Choose sub sub category'),
                              onChanged: viewModel.onSubSubCategoryChanged,
                              items: viewModel.subSubCategories
                                  .map((String subSubCategory) {
                                    return DropdownMenuItem<String>(
                                      value: subSubCategory,
                                      child: Text(subSubCategory),
                                    );
                                  })
                                  .toList(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              ),
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
                          onTap: viewModel.onPostProduct,
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
        ),
      ),
    );
  }
}
