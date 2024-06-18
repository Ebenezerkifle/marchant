import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../views/widgets/custome_button.dart';
import 'file_view_dialog_model.dart';

class FileViewDialog extends StackedView<FileViewDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const FileViewDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    FileViewDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          request.title ?? 'Upload File',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        verticalSpaceMedium,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            viewModel.theFileIsImage(request.description ?? '')
                                ? SizedBox(
                                    height: screenHeightFraction(context,
                                        dividedBy: 3),
                                    width: screenWidth(context) * .6,
                                    child: Image.file(
                                      request.data,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    FontAwesomeIcons.solidFile,
                                    color: kcPrimaryColorDark,
                                    size: 60,
                                  ),
                          ],
                        ),
                        if (request.description != null) ...[
                          verticalSpaceSmall,
                          Text(
                            request.description!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: kcMediumGrey,
                            ),
                            maxLines: 3,
                            softWrap: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomeButton(
                    width: screenHeightFraction(context, dividedBy: 7),
                    text: 'Cancle',
                    stroke: true,
                    textColor: kcPrimaryColor,
                    btnColor: kcPrimaryColor,
                    onTap: () => completer(
                        DialogResponse(confirmed: true, data: [false])),
                  ),
                  CustomeButton(
                    width: screenHeightFraction(context, dividedBy: 7),
                    text: 'Upload',
                    btnColor: kcPrimaryColor,
                    onTap: () =>
                        completer(DialogResponse(confirmed: true, data: [
                      true,
                    ])),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FileViewDialogModel viewModelBuilder(BuildContext context) =>
      FileViewDialogModel();
}
