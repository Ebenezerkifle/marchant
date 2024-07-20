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
          CustomeAppBar(title: viewModel.postProduct, back: false),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      verticalSpaceMiddle,
                      // Display uploaded images
                      if (viewModel.images.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.images.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              viewModel.images[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () =>
                                              viewModel.removeImage(index),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              );
                            },
                          ),
                        ),
                      //add picture section
                      GestureDetector(
                        onTap: viewModel.onPictureAdd,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kcVeryLightGrey,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.plus,
                                color: kcPrimaryColor,
                              ),
                              verticalSpaceSmall,
                              Text(
                                viewModel.addPictures,
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
                          hint: viewModel.nameHint,
                          height: 50,
                        ),
                      ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: viewModel.topCategory,
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                              child: DropdownButtonFormField<String>(
                                value: viewModel.selectedCategory,
                                hint: Text(viewModel.topCategoryHint),
                                onChanged: viewModel.onCategoryChanged,
                                items: viewModel.topCategories.values
                                    .map((Category category) {
                                  return DropdownMenuItem<String>(
                                    value: category.id,
                                    child: Text(category.name ?? ''),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: viewModel.formError
                                              .containsKey('category')
                                          ? Colors.red
                                          : kcPrimaryColorDark,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceMiddle,
                      if (viewModel.selectedCategory != null)
                        CustomeFormField(
                          title: viewModel.subCategory,
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: DropdownButtonFormField<String>(
                                  value: viewModel.selectedSubCategory,
                                  hint: Text(viewModel.subCategoryHint),
                                  onChanged: viewModel.onSubCategoryChanged,
                                  items: viewModel.subCategories
                                      .map((Category subCategory) {
                                    return DropdownMenuItem<String>(
                                      value: subCategory.id,
                                      child: Text(subCategory.name ?? ''),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: viewModel.formError
                                                .containsKey('subCategory')
                                            ? Colors.red
                                            : kcPrimaryColorDark,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      verticalSpaceMiddle,
                      if (viewModel.selectedSubCategory != null)
                        CustomeFormField(
                          title: viewModel.subSubCategory,
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: DropdownButtonFormField<String>(
                                  value: viewModel.selectedSubSubCategory,
                                  hint: Text(viewModel.subSubCategoryHint),
                                  onChanged: viewModel.onSubSubCategoryChanged,
                                  items: viewModel.subSubCategories
                                      .map((Category subSubCategory) {
                                    return DropdownMenuItem<String>(
                                      value: subSubCategory.id,
                                      child: Text(subSubCategory.name ?? ''),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: viewModel.formError
                                                .containsKey('subCategory')
                                            ? Colors.red
                                            : kcPrimaryColorDark,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (viewModel.selectedSubSubCategory != null) ...[
                        verticalSpaceMiddle
                      ],
                      CustomeFormField(
                        title: viewModel.salesPrice,
                        widget: InputField(
                          validator: (value) => viewModel.validateText(value,
                              viewModel.salesPriceController, 'Sales price'),
                          error: viewModel.formError
                              .containsKey(viewModel.salesPriceController),
                          controller: viewModel.salesPriceController,
                          hint: viewModel.salesPriceHint,
                          height: 50,
                          inputType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        ),
                      ),

                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: viewModel.detailsMsg,
                        widget: InputField(
                          validator: (value) => viewModel.validateText(
                              value,
                              viewModel.detailsController,
                              'Details (comma separated)'),
                          error: viewModel.formError
                              .containsKey(viewModel.detailsController),
                          controller: viewModel.detailsController,
                          hint: viewModel.detailsMsgHint,
                          // hint: 'Enter details (comma separated)',
                          extendable: true,
                          charLength: 1500,
                          height: 100.0,
                        ),
                      ),
                      verticalSpaceMiddle,
                      CustomeFormField(
                        title: viewModel.description,
                        widget: InputField(
                          validator: (value) => viewModel.validateText(value,
                              viewModel.descriptionController, 'Description'),
                          error: viewModel.formError
                              .containsKey(viewModel.descriptionController),
                          controller: viewModel.descriptionController,
                          hint: viewModel.descriptionHint,
                          extendable: true,
                          charLength: 1500,
                          height: 100.0,
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
                        text: viewModel.submit,
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
