import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/image_builder.dart';
import 'signup_viewmodel.dart';

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageBuilder(
                image: viewModel.image,
                height: screenHeight(context) * .4,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: middleSize),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      Text(viewModel.signUpMsg, style: AppTextStyle.h2Bold),
                      verticalSpaceMiddle,
                      // Name field
                      InputField(
                        validator: (value) => viewModel.validateAText(
                          value,
                          viewModel.nameHint,
                          viewModel.nameController,
                          minLength: 3,
                          maxLength: 20,
                        ),
                        controller: viewModel.nameController,
                        error: viewModel.formError
                            .containsKey(viewModel.nameController),
                        prefixIcon: Icon(
                          FontAwesomeIcons.solidUser,
                          color: kcPrimaryColorDark,
                          size: viewModel.iconSize,
                        ),
                        hint: viewModel.nameHint,
                      ),
                      verticalSpaceMiddle,
                      // phone number field
                      InputField(
                        validator: (value) => viewModel.validatePhoneNumber(
                            value, viewModel.phoneNumController),
                        controller: viewModel.phoneNumController,
                        error: viewModel.formError
                            .containsKey(viewModel.phoneNumController),
                        inputType: TextInputType.phone,
                        charLength: 10,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        prefixIcon: Icon(
                          FontAwesomeIcons.phone,
                          color: kcPrimaryColorDark,
                          size: viewModel.iconSize,
                        ),
                        hint: viewModel.phoneNumFieldHint,
                      ),
                      verticalSpaceMiddle,
                      // Location field
                      InputField(
                        validator: (value) => viewModel.validateAText(
                          value,
                          viewModel.locationHint,
                          viewModel.locationController,
                          minLength: 5,
                        ),
                        controller: viewModel.locationController,
                        error: viewModel.formError
                            .containsKey(viewModel.locationController),
                        inputType: TextInputType.text,
                        charLength: 40,
                        prefixIcon: Icon(
                          FontAwesomeIcons.locationDot,
                          color: kcPrimaryColorDark,
                          size: viewModel.iconSize,
                        ),
                        hint: viewModel.locationHint,
                      ),
                      verticalSpaceMiddle,
                      // error message widget
                      viewModel.formError.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                verticalSpaceSmall,
                                Text(
                                  viewModel.formError.entries.first.value,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.withColor(
                                    color: kcDanger,
                                    style: AppTextStyle.thinSmall,
                                  ),
                                ),
                                verticalSpaceSmall,
                              ],
                            )
                          : verticalSpaceMedium,
                      // proceed button comes next!
                      CustomeButton(
                        text: 'Next',
                        onTap: viewModel.onNext,
                        width: double.infinity,
                        loading: viewModel.isBusy,
                        textStyle: AppTextStyle.withColor(
                          color: kcWhite,
                          style: AppTextStyle.h3Bold,
                        ),
                      ),
                      verticalSpaceMiddle,
                      // Register text button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            viewModel.haveAccount,
                            style: AppTextStyle.h4Normal,
                          ),
                          horizontalSpaceSmall,
                          InkWell(
                            onTap: viewModel.onSignIn,
                            child: Text(
                              'Sign in',
                              style: AppTextStyle.withColor(
                                color: kcPrimaryColor,
                                style: AppTextStyle.h3Bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SignupViewModel viewModelBuilder(BuildContext context) => SignupViewModel();
}
