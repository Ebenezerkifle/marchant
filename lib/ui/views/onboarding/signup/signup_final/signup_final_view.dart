import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/input_field.dart';
import 'signup_final_viewmodel.dart';

class SignupFinalView extends StackedView<SignupFinalViewModel> {
  const SignupFinalView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupFinalViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: middleSize),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      Text(viewModel.passMsg, style: AppTextStyle.h2Bold),
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
                        hint: viewModel.passHint,
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
                        hint: viewModel.confirmHint,
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
                        text: 'Submit',
                        onTap: viewModel.onNext,
                        width: double.infinity,
                        loading: viewModel.isBusy,
                        textStyle: AppTextStyle.withColor(
                          color: kcWhite,
                          style: AppTextStyle.h3Bold,
                        ),
                      ),
                      verticalSpaceMiddle,
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  SignupFinalViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupFinalViewModel();
}
