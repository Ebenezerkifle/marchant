import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChooseCatagoryViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  Map<String, String> catagories = {
    "a": "Electronics",
    "b": "Restaurant",
    "c": "Construction",
    "d": "Agricultur",
    "e": "Mini-market",
  };

  Map<String, String> selected = {};

  onSelected(var key) {
    selected.clear();
    selected[key] = key;
    notifyListeners();
  }

  onSubmit() {
    _navigation.clearStackAndShow(Routes.homeView);
  }
}
