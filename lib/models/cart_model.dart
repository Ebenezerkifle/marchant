// import 'package:marchant/models/product_model.dart';

// class CartModel {
//   String? id;
//   ProductModel? product;
//   num? count;
//   num? totalPrice;

//   CartModel({this.id, this.product, this.count, this.totalPrice});
// }




import 'package:marchant/models/product_model.dart';

class CartModel {
  String? id;
  ProductModel? product;
  num? count;
  num? totalPrice;

  CartModel({this.id, this.product, this.count, this.totalPrice});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product?.toMap(),
      'count': count,
      'totalPrice': totalPrice,
    };
  }
}
