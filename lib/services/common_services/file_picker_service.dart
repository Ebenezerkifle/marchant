import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.dialogs.dart';
import '../../app/app.locator.dart';
import '../state_service/snackbar_service.dart';

class FilePickerService with ListenableServiceMixin {
  final _dialogService = locator<DialogService>();

  FilePickerService() {
    listenToReactiveValues([_loading, _progress, _downloadLink]);
  }

  FilePickerResult? filePickerResult;
  File? file;
  List<String> allowsExtensions = [];
  final _loading = ReactiveValue(false);
  bool get loading => _loading.value;
  final _fileName = ReactiveValue('');
  String get fileName => _fileName.value;
  final _progress = ReactiveValue(0.0);
  double get progress => _progress.value;
  final _downloadLink = ReactiveValue('');
  String get downloadLink => _downloadLink.value;
  final _images = ReactiveList<String>();
  List<String> get images => _images;

  pickFile() async {
    filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'PNG', 'JPEG', 'jpeg'],
    );
  }

  showDialogAndUpload(DialogType variant) async {
    if (filePickerResult != null) {
      String fileName = filePickerResult!.files.first.name;
      var filePath = filePickerResult!.files.first.path;
      file = File(filePath.toString());
      // show dialog
      var compeleter = await _dialogService.showCustomDialog(
        variant: variant,
        description: fileName,
        data: file,
      );
      // users response on the dialog.
      if (compeleter?.data[0] == true) {
        // upload file
        SnackBarService.showSnackBar(content: 'Uploading the file...');
        final storageRef = FirebaseStorage.instance.ref();
        try {
          if (file != null) {
            _loading.value = true;
            _fileName.value = fileName;
            final childRef = storageRef.child(fileName);
            UploadTask uploadTask = childRef.putFile(file!);
            notifyListeners();
            // Listen for state changes, errors, and completion of the upload
            uploadTask.snapshotEvents.listen(
              (TaskSnapshot snapshot) {
                _progress.value =
                    snapshot.bytesTransferred / snapshot.totalBytes;
                notifyListeners();
              },
              onError: (dynamic error) {
                SnackBarService.showSnackBar(
                    content: 'an error occured while uploading...');
                if (kDebugMode) {
                  print('Error: $error');
                }
              },
              onDone: () async {
                SnackBarService.showSnackBar(content: 'Successfully uploaded!');
                final downloadUrl = await childRef.getDownloadURL();
                _progress.value = 1.0;
                _downloadLink.value = downloadUrl;
                _loading.value = false;
                _images.add(downloadUrl);
                notifyListeners();
              },
            );
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    } else {
      // nothing selected.......
    }
  }

  clear() {
    //
    _downloadLink.value = '';
  }
}
