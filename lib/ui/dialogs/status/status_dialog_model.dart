import 'package:marchant/services/state_service/request_status_service_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class StatusDialogModel extends ReactiveViewModel {
  final _statusService = locator<RequestStatusServiceService>();
  @override
  List<ListenableServiceMixin> get listenableServices => [_statusService];

  RequestStatus get status => _statusService.status;
  String get title => _statusService.title;
  String get description => _statusService.description;
}
