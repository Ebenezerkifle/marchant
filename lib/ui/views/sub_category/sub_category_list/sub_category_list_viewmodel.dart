import 'package:easy_localization/easy_localization.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SubCategoryListViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final String categoryId;
   String get allCategoriesText => "all_sub_categories".tr();

  SubCategoryListViewModel({required this.categoryId});
// Method to navigate to SubCategoryView
  void navigateToSubCategory(String subSubCategoryId) {
    _navigation.navigateToSubCategoryView(
        subSubCategoryValue: subSubCategoryId, categoryValue: categoryId);
  }
}
