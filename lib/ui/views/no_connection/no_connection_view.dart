


import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:stacked/stacked.dart';

import 'no_connection_viewmodel.dart';

class NoConnectionView extends StackedView<NoConnectionViewModel> {
  const NoConnectionView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NoConnectionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Smaller Icon
              const Icon(
                Icons.wifi_off,
                size: 80,
                color: kcPrimaryColor,
              ),
              const SizedBox(height: 15),
              Text(
                "No Internet Connection",
                style: AppTextStyle.h2Bold.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: viewModel.isBusy ? null : viewModel.runStartupLogic,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: viewModel.isBusy
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        "Retry",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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
  NoConnectionViewModel viewModelBuilder(BuildContext context) =>
      NoConnectionViewModel();
}
