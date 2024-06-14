class ProductModel {
  String? id;
  String? productName;
  String? productTag;
  List<String>? productImage;
  String? manufacturerId;
  String? categoryId;
  String? subCategoryId;
  String? subSubCategoryId;
  num? salesPrice;
  String? description;
  List<String>? details;
  num? quantity;
  String? soldAmount;
  String? status;

  ProductModel({
    this.id,
    this.productName,
    this.productTag,
    this.productImage,
    this.manufacturerId,
    this.categoryId,
    this.subCategoryId,
    this.subSubCategoryId,
    this.salesPrice,
    this.description,
    this.quantity,
    this.soldAmount,
    this.status,
    this.details
  });

  // Optional: Add a method to convert to a map for easier printing or debugging
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'productTag': productTag,
      'productImage': productImage,
      'manufacturerId': manufacturerId,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'subSubCategoryId': subSubCategoryId,
      'salesPrice': salesPrice,
      'description': description,
      'quantity': quantity,
      'soldAmount': soldAmount,
      'status': status,
      'details':details
    };
  }

  // Optional: Add a factory constructor to create a ProductModel from a map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      productName: map['productName'],
      productTag: map['productTag'],
      productImage: List<String>.from(map['productImage'] ?? []),
      details: List<String>.from(map['details'] ?? []),
      manufacturerId: map['manufacturerId'],
      categoryId: map['categoryId'],
      subCategoryId: map['subCategoryId'],
      subSubCategoryId: map['subSubCategoryId'],
      salesPrice: map['salesPrice'],
      description: map['description'],
      quantity: map['quantity'],
      soldAmount: map['soldAmount'],
      status: map['status'],
    );
  }



  //  Map<String, dynamic> toJson() {
  //   return {
  //     'productName': productName,
  //     'salesPrice': salesPrice,
  //     'productImage': productImage,
  //   };
  // }
}



// class ProductModel {
//   String? id;
//   String? title;
//   String? description;
//   List<String>? details;
//   num? price;
//   String? provider;
//   List<String>? images;

//   ProductModel({
//     this.id,
//     this.title,
//     this.description,
//     this.details,
//     this.price,
//     this.provider,
//     this.images,
//   });
// }


