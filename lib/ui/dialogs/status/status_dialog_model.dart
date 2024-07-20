import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/state_service/request_status_service.dart';

class StatusDialogModel extends ReactiveViewModel {
  final _statusService = locator<RequestStatusService>();
  @override
  List<ListenableServiceMixin> get listenableServices => [_statusService];

  RequestStatuss get status => _statusService.status;
  String get title => _statusService.title;
  String get description => _statusService.description;
}
