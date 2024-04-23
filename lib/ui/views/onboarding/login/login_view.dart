import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
import 'package:marchant/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: mediumSize),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Welcome messages.
                  Text(
                    viewModel.welcomeMsg,
                    style: AppTextStyle.withSize(
                      style: AppTextStyle.h3Bold,
                      weight: FontWeight.normal,
                    ),
                  ),
                  Stack(
                    children: [
                      ImageBuilder(
                        image: viewModel.image,
                        height: screenHeight(context) * .4,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  verticalSpaceMiddle,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: mediumSize,
                      right: mediumSize,
                    ),
                    child: Column(
                      children: [
                        Text(viewModel.singinMsg, style: AppTextStyle.h2Bold),
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
                        // password field
                        InputField(
                          validator: (value) => viewModel.validatePassword(
                              value, viewModel.passwordController),
                          controller: viewModel.passwordController,
                          error: viewModel.formError
                              .containsKey(viewModel.passwordController),
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
                          hint: viewModel.passwordHint,
                          hideText: !viewModel.passwordVisible,
                        ),
                        verticalSpaceMiddle,
                        // forgot password text.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: viewModel.onForgotPassword,
                              child: Text(
                                viewModel.forgotPass,
                                style: AppTextStyle.withColor(
                                  color: kcPrimaryColor,
                                  style: AppTextStyle.h4Normal,
                                ),
                              ),
                            ),
                            horizontalSpaceSmall,
                          ],
                        ),
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
                          text: viewModel.loginButtonText,
                          onTap: viewModel.onLoginButton,
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
                              viewModel.dontHaveAccMsg,
                              style: AppTextStyle.h4Normal,
                            ),
                            horizontalSpaceSmall,
                            InkWell(
                              onTap: viewModel.onRegister,
                              child: Text(
                                viewModel.register,
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
                  const SizedBox(height: 30),
                  //Text(viewModel.copyright, style: AppTextStyle.verySmall),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
