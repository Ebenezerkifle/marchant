import 'package:stacked/stacked.dart';

enum RequestStatus {
  none,
  loading,
  success,
  error,
}

class RequestStatusServiceService with ListenableServiceMixin {
  RequestStatusServiceService() {
    listenToReactiveValues([_status, _title, _description]);
  }
  final _status = ReactiveValue<RequestStatus>(RequestStatus.none);
  final _title = ReactiveValue('');
  final _description = ReactiveValue('');

  RequestStatus get status => _status.value;
  String get title => _title.value;
  String get description => _description.value;

  void changeStatus(
      {RequestStatus? status, String? title, String? description}) {
    _status.value = status ?? _status.value;
    _title.value = title ?? _title.value;
    _description.value = description ?? _description.value;
    notifyListeners();
  }

  void resetStatus() {
    _status.value = RequestStatus.none;
  }
}
