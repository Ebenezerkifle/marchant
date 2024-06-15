// import 'package:marchant/models/cart_model.dart';

// class OrderModel {
//   String id;
//   List<CartModel>? cartList;
//   num? count;
//   num? totalPrice;

//   OrderModel({
//     required this.id,
//     this.cartList,
//     this.count,
//     this.totalPrice,
//   });
// }





import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/product_model.dart';

class OrderModel {
  List<Map<String, dynamic>> products;
  String? id;
  num? count;
  num? totalPrice;

  OrderModel({
    required this.products,
    this.id,
    this.count,
    this.totalPrice,
  });

  List<CartModel> get cartList => products.map((product) {
    return CartModel(
      id: product['productId'],
      count: product['quantity'],
      // Assuming you have a method to get a product by its ID
      product: ProductModel(id: product['productId'], productName: 'Sample', salesPrice: 0),
    );
  }).toList();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products,
    };
  }

  // Optional: Add a factory constructor to create a OrderModel from a map
  // factory OrderModel.fromMap(Map<String, dynamic> map) {
  //   return OrderModel(
  //     id: map['_id'],
  //     products: List<String>.from(map['products'] ?? []),
  //   );
  // }
}
