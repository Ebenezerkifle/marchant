import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/common_services/file_picker_service.dart';
import 'package:marchant/services/state_service/enrollment_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/post_state_service.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/services/validation_service/front_validation.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app.dialogs.dart';
import '../../../../services/state_service/snackbar_service.dart';

class PostViewModel extends ReactiveViewModel {
  final _enrollmentService = locator<EnrollmentStateService>();
  final _filePicker = FilePickerService();
  final _userService = locator<UserService>();
  final _postService = locator<PostStateService>();
  final _landing = locator<LandingStateService>();

  bool _loading = false;
  bool get loading => _loading;

  PostViewModel() {
    _init();
  }

  // onPictureAdd() async {
  //   // on adding pictures.
  //   await _filePicker.pickFile();
  //   await _filePicker.showDialogAndUpload(DialogType.fileView);
  // }

onPictureAdd() async {
    // Pick a file (image)
    await _filePicker.pickFile();
    // Ensure an image is picked before showing the upload dialog
    if (_filePicker.images.isNotEmpty) {
      await _filePicker.showDialogAndUpload(DialogType.fileView);
    } else {
      // Handle case where no image is selected
      SnackBarService.showSnackBar(content: 'Please select an image.');
    }
  }

  _init() async {
    _loading = true;
    notifyListeners();
    try {
      await _enrollmentService.getTopCategories();
    } catch (e) {
      _errorMessage = 'Failed to load categories';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_enrollmentService, _filePicker];

  Map<String, Category> get topCategories => _enrollmentService.topCategories;
  Map<String, String> selected = {};

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String get name => 'Product name';

  // Controllers for text fields
  TextEditingController productNameController = TextEditingController();
  TextEditingController salesPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tinController = TextEditingController();

  List<Category> subCategories = [];
  List<Category> subSubCategories = [];

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedSubSubCategory;

  // Lists for details and images
  List<String> details = [];
  List<String> get images => _filePicker.images;

  void onCategoryChanged(String? newValue) {
    selectedCategory = newValue;
    // Reset sub-categories and sub-sub-categories when category changes
    selectedSubCategory = null;
    selectedSubSubCategory = null;
    subCategories = [];
    subSubCategories = [];

    // Populate sub-categories based on selected category
    if (newValue != null) {
      subCategories = topCategories[newValue]?.subcategory ?? [];
    }

    notifyListeners();
  }

  void onSubCategoryChanged(String? newValue) {
    // print(newValue);

    selectedSubCategory = newValue;
    // Reset sub-sub-categories when sub-category changes
    selectedSubSubCategory = null;
    subSubCategories = [];

    // Populate sub-sub-categories based on selected sub-category
    if (newValue != null && selectedCategory != null) {
      subSubCategories = subCategories
              .firstWhere((subCat) => subCat.id == newValue,
                  orElse: () => Category(subcategory: []))
              .subcategory ??
          [];
    }

    notifyListeners();
  }

  void onSubSubCategoryChanged(String? newValue) {
    print(newValue);
    selectedSubSubCategory = newValue;
    notifyListeners();
  }

  Future<void> refresh() async {
    try {
      setBusy(true); // Set busy state to indicate loading
    await _postService.getProducts();
    } finally {
      setBusy(false); // Always unset busy state after operation
    }
  }

  String errorMsg = '';

  // Handle form submission
  void onPostProduct() async {
    // _formError.remove('response');
    errorMsg = '';

    if (_formKey.currentState!.validate() &&
        _formError.isEmpty &&
        validateDropdowns() &&
        _filePicker.images.isNotEmpty
        ) {
      setBusy(true);
      Response response;

      // Create product model
      var product = ProductModel(
        productName: productNameController.text,
        details:
            detailsController.text.split(',').map((e) => e.trim()).toList(),
        productImage: images,
        manufacturerId: _userService.user?.id ?? '',
        description: descriptionController.text,
        address: addressController.text,
        quantity: num.parse(quantityController.text),
        categoryId: selectedCategory,
        subCategoryId: selectedSubCategory,
        subSubCategoryId: selectedSubSubCategory,
        salesPrice: num.parse(salesPriceController.text),
      );

      // Send product data to server
      response = await _postService.sendProduct(product);

      if (response.statusCode == 200 || response.statusCode == 201) {
        SnackBarService.showSnackBar(
          content:
              'Your Product is successfuly uploaded, please wait till approved',
        );
        _clearFields();
        refresh();
        _landing.setIndex(0);
      } else {
        // not successful
        if (response.body.contains('{')) {
          try {
            var body = jsonDecode(response.body);
            var message = body['message'];
            _formError['response'] = message;
          } catch (e) {
            _formError['response'] = response.body.toString();
          }
        } else {
          _formError['response'] = response.body.toString();
        }
      }
      setBusy(false);
      notifyListeners();
    }
  }
void _clearFields() {
  productNameController.clear();
  salesPriceController.clear();
  descriptionController.clear();
  detailsController.clear();
  quantityController.clear();
  companyNameController.clear();
  addressController.clear();
  tinController.clear();
  selectedCategory = null;
  selectedSubCategory = null;
  selectedSubSubCategory = null;
  details.clear();
  _formError.clear();
  errorMsg = '';
}

  //---------------- FRONT END VALIDATION -------------

  _setStateOfFormField(String msg, var controller) {
    // takes the validation result and set the state
    if (msg.isNotEmpty) {
      _formError[controller] = msg;
      notifyListeners();
      return;
    } else {
      _formError.remove(controller);
      notifyListeners();
      return;
    }
  }

  // validate
  validateText(String value, var controller, String label,
      {int? minLength, int? maxLength}) {
    return _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        label,
        minLength: minLength,
        maxLength: maxLength,
      ),
      controller,
    );
  }

  // Validate dropdowns
  bool validateDropdowns() {
    bool isValid = true;

    if (selectedCategory == null) {
      _formError['category'] = 'Choose a category';
      isValid = false;
    } else {
      _formError.remove('category');
    }

    if (selectedSubCategory == null) {
      _formError['subCategory'] = 'Choose a sub category';
      isValid = false;
    } else {
      _formError.remove('subCategory');
    }

    if (selectedSubSubCategory == null) {
      _formError['subSubCategory'] = 'Choose a sub sub category';
      isValid = false;
    } else {
      _formError.remove('subSubCategory');
    }

    notifyListeners();
    return isValid;
  }
}


