import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/views/onboarding/change_paswords/change_paswords_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';
import '../../../common/ui_helpers.dart';
import '../../widgets/custome_app_bar.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/custome_form_field.dart';
import '../../widgets/input_field.dart';

class ChangePasswordView extends StackedView<ChangePasswordsViewModel> {
  const ChangePasswordView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ChangePasswordsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(title: viewModel.title.trim()),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        verticalSpaceLarge,
                        CustomeFormField(
                          title: viewModel.password,
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                              value,
                              viewModel.passwordController,
                              viewModel.password.trim(),
                              minLength: 6,
                              maxLength: 12,
                            ),
                            controller: viewModel.passwordController,
                            hint: viewModel.passwordHint,
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              color: kcPrimaryColor.withOpacity(.5),
                              size: iconSize,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: viewModel.togglePrevPass,
                              child: viewModel.prevPassVisible
                                  ? const Icon(Icons.visibility, size: iconSize)
                                  : const Icon(Icons.visibility_off,
                                      size: iconSize),
                            ),
                            hideText: !viewModel.prevPassVisible,
                            error: viewModel.formError.containsKey(
                              viewModel.passwordController,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: viewModel.newPassword,
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                              value,
                              viewModel.newPasswordController,
                              viewModel.newPassword.trim(),
                              minLength: 6,
                              maxLength: 12,
                            ),
                            controller: viewModel.newPasswordController,
                            hint: viewModel.newPasswordHint,
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              color: kcPrimaryColor.withOpacity(.5),
                              size: iconSize,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: viewModel.toggleNewPass,
                              child: viewModel.newPassVisible
                                  ? const Icon(Icons.visibility, size: iconSize)
                                  : const Icon(Icons.visibility_off,
                                      size: iconSize),
                            ),
                            hideText: !viewModel.newPassVisible,
                            error: viewModel.formError.containsKey(
                              viewModel.newPasswordController,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: viewModel.confirmPassword,
                          widget: InputField(
                            validator: (value) => viewModel.validateConfirmPass(
                              value,
                              viewModel.newPasswordController.text,
                              viewModel.confirmPasswordController,
                            ),
                            controller: viewModel.confirmPasswordController,
                            hint: viewModel.confirmPasswordHint,
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              color: kcPrimaryColor.withOpacity(.5),
                              size: iconSize,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: viewModel.toggleconfirmPass,
                              child: viewModel.confirmPassVisible
                                  ? const Icon(Icons.visibility, size: iconSize)
                                  : const Icon(Icons.visibility_off,
                                      size: iconSize),
                            ),
                            hideText: !viewModel.confirmPassVisible,
                            error: viewModel.formError.containsKey(
                              viewModel.confirmPasswordController,
                            ),
                          ),
                        ),
                        verticalSpaceLarge,
                        if (viewModel.hasError &&
                                viewModel.errorMsg.isNotEmpty ||
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
                          text: 'submit',
                          onTap: viewModel.onSubmit,
                          width: double.infinity,
                          btnColor: kcPrimaryColor,
                          loading: viewModel.isBusy,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  ChangePasswordsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChangePasswordsViewModel();
}
