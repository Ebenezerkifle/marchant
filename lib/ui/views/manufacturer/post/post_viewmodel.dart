import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/services/state_service/enrollment_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _enrollmentService = locator<EnrollmentStateService>();
  final _userService = locator<UserService>();
  final _landingStateService = locator<LandingStateService>();

  bool _loading = false;
  bool get loading => _loading;

  PostViewModel() {
    _init();
  }

  _init() async {
    _loading = true;
    notifyListeners();
    try {
      await _enrollmentService.getTopCategories();
    } catch (e) {
      _errorMessage = 'Failed to load categories: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_enrollmentService];

  Map<String, Category> get topCategories => _enrollmentService.topCategories;
  Map<String, String> selected = {};

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  // Controllers for text fields
  TextEditingController productNameController = TextEditingController();
  TextEditingController salesPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tinController = TextEditingController();

  List<String> subCategories = [];
  List<String> subSubCategories = [];

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedSubSubCategory;

  void onCategoryChanged(String? newValue) {
    selectedCategory = newValue;
    // Reset sub-categories and sub-sub-categories when category changes
    selectedSubCategory = null;
    selectedSubSubCategory = null;
    subCategories = [];
    subSubCategories = [];

    // Populate sub-categories based on selected category
    if (newValue != null) {
      subCategories = topCategories[newValue]?.subcategory?.map((subCat) => subCat.name ?? "").toList() ?? [];
    }

    notifyListeners();
  }

  void onSubCategoryChanged(String? newValue) {
    selectedSubCategory = newValue;
    // Reset sub-sub-categories when sub-category changes
    selectedSubSubCategory = null;
    subSubCategories = [];

    // Populate sub-sub-categories based on selected sub-category
    if (newValue != null && selectedCategory != null) {
      subSubCategories = topCategories[selectedCategory]?.subcategory
              ?.firstWhere((subCat) => subCat.name == newValue, orElse: () => Category(subcategory: []))
              .subcategory
              ?.map((subSubCat) => subSubCat.name ?? "")
              .toList() ??
          [];
    }

    notifyListeners();
  }

  void onSubSubCategoryChanged(String? newValue) {
    selectedSubSubCategory = newValue;
    notifyListeners();
  }

  void onPostProduct() {
    // Handle post product logic here
  }
}
