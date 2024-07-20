import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/services/state_service/request_status_service_service.dart';
import 'package:marchant/ui/common/ui_helpers.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_style.dart';
import 'status_dialog_model.dart';

class StatusDialog extends StackedView<StatusDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const StatusDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StatusDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                viewModel.status == RequestStatus.loading
                    ? Column(
                        children: [
                          const CircularProgressIndicator(
                            color: kcPrimaryColor,
                            strokeWidth: 3,
                          ),
                          verticalSpaceSmall,
                          Text(
                            viewModel.description.isNotEmpty
                                ? viewModel.description
                                : 'loading'.tr(),
                            style: AppTextStyle.h4Normal,
                          )
                        ],
                      )
                    : viewModel.status == RequestStatus.success
                        ? buildWidget(
                            title: viewModel.title.isNotEmpty
                                ? viewModel.title
                                : 'Success',
                            description: viewModel.description,
                            icon: FontAwesomeIcons.check,
                          )
                        : buildWidget(
                            title: viewModel.title.isNotEmpty
                                ? viewModel.title
                                : 'Error',
                            description: viewModel.description,
                            icon: FontAwesomeIcons.triangleExclamation,
                          )
              ],
            ),
            if (viewModel.status != RequestStatus.loading) ...[
              verticalSpaceMiddle,
              GestureDetector(
                onTap: () => locator<DialogService>().completeDialog(
                  DialogResponse(
                    confirmed: true,
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.solidCircleXmark,
                  color: kcPrimaryColor.withOpacity(.8),
                  size: 35,
                ),
              )
            ],
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  buildWidget({required title, required description, required icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: massiveSize - 40,
            width: massiveSize - 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: kcPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: kcWhite,
              size: 50,
            )),
        verticalSpaceMiddle,
        Text(title, style: AppTextStyle.h1Bold),
        verticalSpaceSmall,
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppTextStyle.h4Normal,
        )
      ],
    );
  }

  @override
  StatusDialogModel viewModelBuilder(BuildContext context) =>
      StatusDialogModel();
}
