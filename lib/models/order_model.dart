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

class OrderModel {
  String id;
  List<CartModel>? cartList;
  num? count;
  num? totalPrice;

  OrderModel({
    required this.id,
    this.cartList,
    this.count,
    this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartList': cartList?.map((item) => item.toMap()).toList(),
      'count': count,
      'totalPrice': totalPrice,
    };
  }
}
