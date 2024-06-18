import 'package:stacked/stacked.dart';

class FileViewDialogModel extends BaseViewModel {
  final RegExp pattern = RegExp('^.*.(jpg|JPG|png|PNG)');

  theFileIsImage(String fileName) {
    return fileName.contains(pattern);
  }
}
