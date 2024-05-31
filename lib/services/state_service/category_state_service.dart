// import 'package:stacked/stacked.dart';
// import 'package:marchant/models/category_model.dart';

// class CategoryStateService with ListenableServiceMixin {
//   CategoryStateService() {
//     listenToReactiveValues([_categories, _selected]);
//     _initializeCategories();
//     _defaultSelected();
//   }

//   final _categories = ReactiveValue<List<CategoryModel>>([]);
//   List<CategoryModel> get categories => _categories.value;

//   final _selected = ReactiveValue<CategoryModel?>(null);
//   CategoryModel? get selectedCategory => _selected.value;

//   void onCategorySelected(CategoryModel category) {
//     _selected.value = category;
//     notifyListeners();
//   }

//   void _defaultSelected() {
//     if (_categories.value.isNotEmpty) {
//       _selected.value = _categories.value.first;
//       notifyListeners();
//     }
//   }

//   void _initializeCategories() {
//     _categories.value = _buildCategories();
//     notifyListeners();
//   }

//   List<CategoryModel> _buildCategories() {
//     return [
//       CategoryModel(
//         id: '1',
//         name: 'Electronics',
//         subCategories: [
//           CategoryModel(
//             id: '1-1',
//             name: 'Mobile',
//             subCategories: [
//               CategoryModel(
//                 id: '1-1-1',
//                 name: 'Smartphones',
//                 subCategories: [
//                   CategoryModel(id: '1-1-1-1', name: 'Android'),
//                   CategoryModel(id: '1-1-1-2', name: 'iOS'),
//                 ],
//               ),
//               CategoryModel(
//                 id: '1-1-2',
//                 name: 'Feature Phones',
//                 subCategories: [
//                   CategoryModel(id: '1-1-2-1', name: 'Basic'),
//                   CategoryModel(id: '1-1-2-2', name: 'Advanced'),
//                 ],
//               ),
//             ],
//           ),
//           CategoryModel(
//             id: '1-2',
//             name: 'Laptops',
//             subCategories: [
//               CategoryModel(
//                 id: '1-2-1',
//                 name: 'Ultrabooks',
//                 subCategories: [
//                   CategoryModel(id: '1-2-1-1', name: 'Windows'),
//                   CategoryModel(id: '1-2-1-2', name: 'Mac'),
//                 ],
//               ),
//               CategoryModel(
//                 id: '1-2-2',
//                 name: 'Gaming Laptops',
//                 subCategories: [
//                   CategoryModel(id: '1-2-2-1', name: 'High-end'),
//                   CategoryModel(id: '1-2-2-2', name: 'Budget'),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//       CategoryModel(
//         id: '2',
//         name: 'Appliances',
//         subCategories: [
//           CategoryModel(
//             id: '2-1',
//             name: 'Refrigerators',
//             subCategories: [
//               CategoryModel(
//                 id: '2-1-1',
//                 name: 'Double Door',
//                 subCategories: [
//                   CategoryModel(id: '2-1-1-1', name: 'Large'),
//                   CategoryModel(id: '2-1-1-2', name: 'Medium'),
//                 ],
//               ),
//               CategoryModel(
//                 id: '2-1-2',
//                 name: 'Single Door',
//                 subCategories: [
//                   CategoryModel(id: '2-1-2-1', name: 'Large'),
//                   CategoryModel(id: '2-1-2-2', name: 'Medium'),
//                 ],
//               ),
//             ],
//           ),
//           CategoryModel(
//             id: '2-2',
//             name: 'TVs',
//             subCategories: [
//               CategoryModel(
//                 id: '2-2-1',
//                 name: 'LED TVs',
//                 subCategories: [
//                   CategoryModel(id: '2-2-1-1', name: '4K'),
//                   CategoryModel(id: '2-2-1-2', name: '1080p'),
//                 ],
//               ),
//               CategoryModel(
//                 id: '2-2-2',
//                 name: 'Smart TVs',
//                 subCategories: [
//                   CategoryModel(id: '2-2-2-1', name: 'Android TV'),
//                   CategoryModel(id: '2-2-2-2', name: 'WebOS'),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ];
//   }
// }
