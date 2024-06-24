import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/post_state_service.dart';
import 'package:stacked/stacked.dart';

class ManuHomeViewModel extends ReactiveViewModel {
  final _landingService = locator<LandingStateService>();
  final _postService = locator<PostStateService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_postService];

  Map<String, ProductModel> get products => _postService.products;

  ManuHomeViewModel() {
    _getMyProducts();
  }

  _getMyProducts() async {
    setBusy(true);
    _postService.getProducts();
    setBusy(false);
  }

  onPostProduct() {
    _landingService.setIndex(1);
  }
}
