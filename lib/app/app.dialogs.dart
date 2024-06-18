// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/file_view/file_view_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';

enum DialogType {
  infoAlert,
  fileView,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.fileView: (context, request, completer) =>
        FileViewDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
