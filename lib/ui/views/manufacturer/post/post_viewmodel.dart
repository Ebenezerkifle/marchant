import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/services/state_service/enrollment_state_service.dart';
import 'package:stacked/stacked.dart';

class PostViewModel extends ReactiveViewModel {
  final _enrollmentService = locator<EnrollmentStateService>();


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
      // print(_errorMessage);
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
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController subCategoryIdController = TextEditingController();
  TextEditingController subSubCategoryIdController = TextEditingController();
  TextEditingController salesPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tinController = TextEditingController();

  List<String> subCategories = ['Sub Category 1', 'Sub Category 2', 'Sub Category 3'];
  List<String> subSubCategories = ['Sub Sub Category 1', 'Sub Sub Category 2', 'Sub Sub Category 3'];

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedSubSubCategory;

  void onCategoryChanged(String? newValue) {
    selectedCategory = newValue;
    notifyListeners();
  }

  void onSubCategoryChanged(String? newValue) {
    selectedSubCategory = newValue;
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
