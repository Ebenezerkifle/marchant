
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/state_service/language_service.dart';
import '../../views/widgets/custome_button.dart';
import 'change_language_sheet_model.dart';

class ChangeLanguageSheet extends StackedView<ChangeLanguageSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ChangeLanguageSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChangeLanguageSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr(request.title ?? 'change_language'.tr()),
            style: AppTextStyle.h2Bold,
          ),
          verticalSpaceMiddle,
          Column(
            children: languageNameCodeMap.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: smallSize),
                    child: CustomeListTile(
                      title: e.key,
                      onTap: () =>
                          viewModel.onLanguageChange(context, e.value, e.key),
                      noImage: true,
                      // noShadow: false,
                      selected: viewModel.currentLanguage == e.key,
                      stackWidget: Positioned(
                          top: 0,
                          bottom: 0,
                          right: middleSize,
                          child: Icon(
                            viewModel.currentLanguage == e.key
                                ? FontAwesomeIcons.circleDot
                                : FontAwesomeIcons.circle,
                            color: kcPrimaryColor,
                          )),
                    ),
                  ),
                )
                .toList(),
          ),
          verticalSpaceMiddle,
          CustomeButton(
              text: 'done'.tr(),
              onTap: () {
                completer!(SheetResponse(confirmed: true));
              },
              width: screenWidth(context)),
          verticalSpaceMiddle,
        ],
      ),
    );
  }

  @override
  ChangeLanguageSheetModel viewModelBuilder(BuildContext context) =>
      ChangeLanguageSheetModel();
}
