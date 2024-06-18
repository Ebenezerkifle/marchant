import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostViewModel extends BaseViewModel {
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

  // Dropdown options and selected values
  List<String> categories = ['Category 1', 'Category 2', 'Category 3'];
  List<String> subCategories = ['Sub Category 1', 'Sub Category 2', 'Sub Category 3'];
  List<String> subSubCategories = ['Sub Sub Category 1', 'Sub Sub Category 2', 'Sub Sub Category 3'];

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedSubSubCategory;

  // Method to handle dropdown changes
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
