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
}
