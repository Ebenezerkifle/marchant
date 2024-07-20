import 'package:stacked/stacked.dart';

enum RequestStatuss {
  none,
  loading,
  success,
  error,
}

class RequestStatusService with ListenableServiceMixin {
  RequestStatusService() {
    listenToReactiveValues([_status, _title, _description]);
  }
  final _status = ReactiveValue<RequestStatuss>(RequestStatuss.none);
  final _title = ReactiveValue('');
  final _description = ReactiveValue('');

  RequestStatuss get status => _status.value;
  String get title => _title.value;
  String get description => _description.value;

  void changeStatus(
      {RequestStatuss? status, String? title, String? description}) {
    _status.value = status ?? _status.value;
    _title.value = title ?? _title.value;
    _description.value = description ?? _description.value;
    notifyListeners();
  }

  void resetStatus() {
    _status.value = RequestStatuss.none;
  }
}
