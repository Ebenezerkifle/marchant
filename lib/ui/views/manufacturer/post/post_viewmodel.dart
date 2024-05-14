import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String get titleHint => 'iPhone 14 Pro Max';
  String get descriptionHint => 'New iphone with elegant view...';
  String get detailsHint => '256 GB';
  String get priceHint => '84,000 ETB';
  String get categoryHint => 'Electronics';
}
