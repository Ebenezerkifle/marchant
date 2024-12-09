import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';
import '../../../common/ui_helpers.dart';
import '../../widgets/custome_button.dart';
import 'otp_viewmodel.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
      viewModelBuilder: () => OtpViewModel(),
      builder: (context, viewModel, child) {
        String strDigits(int n) => n.toString().padLeft(2, '0');
        final minutes = strDigits(viewModel.myDuration.inMinutes.remainder(60));
        final seconds = strDigits(viewModel.myDuration.inSeconds.remainder(60));

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Icon(
                        FontAwesomeIcons.userLock,
                        size: screenHeight(context) * .2,
                        color: kcPrimaryColor,
                      ),
                      verticalSpaceLarge,
                      Text(viewModel.title, style: AppTextStyle.big),
                      Text(viewModel.instruction, style: AppTextStyle.h4Normal),
                      const SizedBox(height: 20),
                      Text('$minutes:$seconds', style: AppTextStyle.h1Bold),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .85,
                        child: OTPTextField(
                          controller: viewModel.otpbox,
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 50,
                          style: AppTextStyle.h1Bold,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (pin) => viewModel.setOtp(pin),
                        ),
                      ),
                      if (viewModel.hasError)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            viewModel.errorMsg.isNotEmpty
                                ? viewModel.errorMsg
                                : 'please_fill_the_field'.tr(),
                            style: AppTextStyle.withColor(
                              color: kcDanger,
                              style: AppTextStyle.thinSmall,
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 40),
                      CustomeButton(
                        onTap: viewModel.onVerify,
                        loading: viewModel.isBusy,
                        btnColor: kcPrimaryColor,
                        text: 'verify'.tr(),
                        textStyle: AppTextStyle.withColor(
                          color: kcWhite,
                          style: AppTextStyle.h3Bold,
                        ),
                        width: MediaQuery.of(context).size.width * .85,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("dont_get_otp".tr(),
                              style: AppTextStyle.h4Normal),
                          InkWell(
                            onTap:
                                viewModel.codeSent ? viewModel.resendOtp : null,
                            child: Text(
                              "resend".tr(),
                              style: AppTextStyle.withColor(
                                color: viewModel.codeSent
                                    ? kcPrimaryColor
                                    : kcPrimaryColor.withOpacity(0.5),
                                style: AppTextStyle.h4Normal,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
