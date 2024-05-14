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
                      //height: screenWidth(context) * .25,
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
                      title: 'Product title',
                      widget: InputField(
                        controller: viewModel.titleController,
                        hint: viewModel.titleHint,
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Product description',
                      widget: InputField(
                        controller: viewModel.descriptionController,
                        hint: viewModel.descriptionHint,
                        extendable: true,
                        charLength: 1000,
                        height: 50,
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Some details',
                      widget: InputField(
                        controller: viewModel.detailsController,
                        hint: viewModel.detailsHint,
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Price per item',
                      widget: InputField(
                        controller: viewModel.priceController,
                        hint: viewModel.priceHint,
                      ),
                    ),
                    verticalSpaceMiddle,
                    CustomeFormField(
                      title: 'Product Category',
                      widget: InputField(
                        controller: viewModel.priceController,
                        hint: viewModel.priceHint,
                      ),
                    ),
                    verticalSpaceLarge,
                    CustomeButton(
                      text: 'Submit',
                      onTap: () {},
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
