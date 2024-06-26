class ProductModel {
  String? id;
  String? productName;
  String? productTag;
  List<String> productImage;
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
  String? companyName;
  String? address;
  String? TIN;
  String? logoImage;

  ProductModel({
    this.id,
    this.productName,
    this.productTag,
    this.productImage = const [],
    this.manufacturerId,
    this.categoryId,
    this.subCategoryId,
    this.subSubCategoryId,
    this.salesPrice,
    this.description,
    this.quantity,
    this.soldAmount,
    this.status,
    this.details,
    this.companyName,
    this.address,
    this.TIN,
    this.logoImage,
  });

  // Optional: Add a method to convert to a map for easier printing or debugging
  Map<String, dynamic> toMap() {
    return {
      'productId': id,
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
      'details': details
    };
  }

  List<ProductModel> productsFromMap(map) {
    List<ProductModel> products = [];
    for (var ele in map) {
      var p = ProductModel.fromMap(ele['productId']);
      products.add(p);
    }
    return products;
  }

  // Optional: Add a factory constructor to create a ProductModel from a map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    print("birhanu!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(map);
    var product = ProductModel(
      id: map['_id'],
      productName: map['productName'] ?? '',
      productTag: map['productTag'],
      productImage: List<String>.from(map['productImage'] as List<dynamic>),
      details: List<String>.from(map['details'] ?? []),
      // manufacturerId: map['manufacturerId'],
      // companyName: map['ManufacturerId'] ?? '',
      // address: map['ManufacturerId'],
      // TIN: map['ManufacturerId'],
      // logoImage: map['ManufacturerId'],
      categoryId: map['categoryId'],
      subCategoryId: map['subCategoryId'],
      subSubCategoryId: map['subSubCategoryId'],
      salesPrice: map['salesPrice'],
      description: map['description'],
      quantity: map['quantity'],
      soldAmount: map['soldAmount'],
      status: map['status'],
    );
    return product;
  }
}
