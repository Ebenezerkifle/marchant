import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

class FileViewDialogModel extends BaseViewModel {
  final RegExp pattern = RegExp('^.*.(jpg|JPG|png|PNG)');

  String get cancelText => "cancel_text".tr();
  String get upload => "upload".tr();
  String get uploadFile => "upload_file".tr();

  theFileIsImage(String fileName) {
    return fileName.contains(pattern);
  }
}
