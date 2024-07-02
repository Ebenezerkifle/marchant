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
      productName:
          map['productName'] != null ? map['productName'] as String : null,

      productTag:
          map['productTag'] != null ? map['productTag'] as String : null,
      // productImage: List<String>.from(map['productImage'] as List<dynamic>),
      productImage: map['productImage'] != null
          ? List<String>.from(map['productImage'] as List<dynamic>)
          : [], // Empty list or null depending on your preference
      details: map['details'] != null
          ? List<String>.from(map['details'] as List<dynamic>)
          : [],
      categoryId:
          map['categoryId'] != null ? map['categoryId'] as String : null,
      subCategoryId:
          map['subCategoryId'] != null ? map['subCategoryId'] as String : null,
      subSubCategoryId: map['subSubCategoryId'] != null
          ? map['subSubCategoryId'] as String
          : null,
      salesPrice: map['salesPrice'] != null ? map['salesPrice'] as num : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as num : null,
      soldAmount:
          map['soldAmount'] != null ? map['soldAmount'] as String : null,
      status: map['status'],
      totalAmount:
          map['totalAmount'] != null ? map['totalAmount'] as num : null,
      companyName: map['ManufacturerId'] != null &&
              map['ManufacturerId']['companyName'] != null
          ? map['ManufacturerId']['companyName'] as String
          : null,
      address: map['ManufacturerId'] != null &&
              map['ManufacturerId']['address'] != null
          ? map['ManufacturerId']['address'] as String
          : null,
      TIN: map['ManufacturerId'] != null && map['ManufacturerId']['TIN'] != null
          ? map['ManufacturerId']['TIN'] as String
          : null,
      logoImage: map['ManufacturerId'] != null &&
              map['ManufacturerId']['logoImage'] != null
          ? map['ManufacturerId']['logoImage'] as String
          : null,
    );
  }
}
