import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

import 'forgot_password_viewmodel.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';
import '../../../common/ui_helpers.dart';
import '../../widgets/custome_app_bar.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/custome_form_field.dart';

class ForgotPasswordView extends StackedView<ForgotPasswordViewModel> {
  const ForgotPasswordView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ForgotPasswordViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(title: viewModel.title),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: middleSize),
              child: Column(
                children: [
                  verticalSpaceLarge,
                  CustomeFormField(
                    title: viewModel.phoneNumber,
                    widget: TextField(
                      decoration: InputDecoration(
                        counterText: '',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 5,
                            color:
                                viewModel.hasError ? kcDanger : kcPrimaryColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        hintText: 'phone_number'.tr(),
                        hintStyle: AppTextStyle.withColor(
                          color: kcPrimaryColor.withOpacity(.5),
                          style: AppTextStyle.h4Normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: viewModel.hasError ? 1 : .5,
                            color:
                                viewModel.hasError ? kcDanger : kcPrimaryColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (phone) =>
                          viewModel.onPhoneNumberChanged(phone),
                    ),
                  ),
                  verticalSpaceMedium,
                  if (viewModel.errorMsg.isNotEmpty) ...[
                    verticalSpaceSmall,
                    Text(
                      viewModel.errorMsg,
                      style: AppTextStyle.withColor(
                        color: kcDanger,
                        style: AppTextStyle.h4Normal,
                      ),
                    ),
                    verticalSpaceSmall,
                  ],
                  CustomeButton(
                    text: 'continue'.tr(),
                    onTap: viewModel.onNext,
                    width: double.infinity,
                    btnColor: kcPrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ForgotPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgotPasswordViewModel();
}
