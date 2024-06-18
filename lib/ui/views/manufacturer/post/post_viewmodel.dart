// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class PostViewModel extends BaseViewModel {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController detailsController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController categoryController = TextEditingController();
//   String get titleHint => 'iPhone 14 Pro Max';
//   String get descriptionHint => 'New iphone with elegant view...';
//   String get detailsHint => '256 GB';
//   String get priceHint => '84,000 ETB';
//   String get categoryHint => 'Electronics';
// }




import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostViewModel extends BaseViewModel {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
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

  // Define any necessary logic for form submission here
}
