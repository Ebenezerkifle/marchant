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
  num? totalAmount;

  ProductModel(
      {this.id,
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
      this.totalAmount});

  // Optional: Add a method to convert to a map for easier printing or debugging
  Map<String, dynamic> toMap() {
    return {
      'productId': id,
      'productName': productName,
      'productTag': productTag,
      'productImage': productImage,
      'ManufacturerId': manufacturerId,
      'CategoryId': categoryId,
      'SubCategoryId': subCategoryId,
      'SubSubCategoryId': subSubCategoryId,
      'salesPrice': salesPrice,
      'description': description,
      'quantity': quantity,
      'SoldAmount': soldAmount,
      'status': status,
      'details': details
    };
  }

  List<ProductModel> productsFromMap(List<dynamic> map) {
    List<ProductModel> products = [];
    for (var ele in map) {
      var p = ProductModel.fromMap(ele);
      products.add(p);
    }
    return products;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      productName: map['productName'] ?? '',
      productTag: map['productTag'],
      productImage: List<String>.from(map['productImage'] as List<dynamic>),
      details: List<String>.from(map['details'] ?? []),
      categoryId: map['categoryId'],
      subCategoryId: map['subCategoryId'],
      subSubCategoryId: map['subSubCategoryId'],
      salesPrice: map['salesPrice'],
      description: map['description'],
      quantity: map['quantity'],
      soldAmount: map['soldAmount'],
      status: map['status'],
      totalAmount: map['totalAmount'],
      // companyName: map['ManufacturerId']['companyName'] ?? '',
      //address: map['ManufacturerId']['address'],
      // TIN: map['ManufacturerId']['TIN'],
      //logoImage: map['ManufacturerId']['logoImage'],
    );
  }
}
