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
  const SignupView({super.key});

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
                      // Password field
                      InputField(
                        validator: (value) => viewModel.validatePassword(
                          value,
                          viewModel.passController,
                        ),
                        controller: viewModel.passController,
                        error: viewModel.formError
                            .containsKey(viewModel.passController),
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: kcPrimaryColorDark,
                          size: viewModel.iconSize,
                        ),
                        suffixIcon: InkWell(
                          onTap: viewModel.togglePasswordVissibility,
                          child: viewModel.passwordVisible
                              ? Icon(
                                  Icons.visibility,
                                  size: viewModel.iconSize,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  size: viewModel.iconSize,
                                ),
                        ),
                        hint: viewModel.passHint,
                        hideText: !viewModel.passwordVisible,
                      ),
                      verticalSpaceMiddle,
                      // Confirm password field
                      InputField(
                        validator: (value) => viewModel.validateConfirmPass(
                          value,
                          viewModel.passController.text,
                          viewModel.confirmController,
                        ),
                        controller: viewModel.confirmController,
                        error: viewModel.formError
                            .containsKey(viewModel.confirmController),
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: kcPrimaryColorDark,
                          size: viewModel.iconSize,
                        ),
                        suffixIcon: InkWell(
                          onTap: viewModel.toggleConfirmPasswordVissibility,
                          child: viewModel.confirmPassVisible
                              ? Icon(
                                  Icons.visibility,
                                  size: viewModel.iconSize,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  size: viewModel.iconSize,
                                ),
                        ),
                        hint: viewModel.confirmHint,
                        hideText: !viewModel.confirmPassVisible,
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
