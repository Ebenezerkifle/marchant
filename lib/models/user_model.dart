import 'dart:convert';

class UserModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? password;
  String? CategoryId;
  String? ManufacturerId;
  final num? transactionAmount;
  final num? creditAvailable;
  final num? tookCredit;
  final num? lastCreditPaid;
  final bool? lastCreditFullyPaid;
  final String? status;
  final String? role;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
    this.CategoryId,
    this.ManufacturerId,
    this.transactionAmount,
    this.creditAvailable,
    this.tookCredit,
    this.lastCreditPaid,
    this.lastCreditFullyPaid,
    this.status,
    this.role,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copywith({
    var phoneNumber,
    var password,
    var categoryId,
  }) {
    return UserModel()
      ..phoneNumber = phoneNumber ?? this.phoneNumber
      ..password = password ?? this.password
      ..CategoryId = categoryId ?? categoryId;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fname': firstName,
      'lname': lastName,
      // 'password': password,
      'phoneNumber': phoneNumber,
      'CategoryId': CategoryId,
    };
 
  }
  Map<String, dynamic> toMapReg() {
    return <String, dynamic>{
      'fname': firstName,
      'lname': lastName,
      'password': password,
      'phoneNumber': phoneNumber,
      'CategoryId': CategoryId,
    };
 
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    // print("Mapping UserModel from map: $map");
    return UserModel(
      firstName: map['fname'] as String?,
      lastName: map['lname'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      password: map['password'] != null ? map['password'] as String : null,
      CategoryId: map['CategoryId'] as String?,
      ManufacturerId: map['ManufacturerId'] as String?,
      transactionAmount: map['transactionAmount'] as num?,
      creditAvailable: map['creditAvailable'] as num?,
      tookCredit: map['tookCredit'] as num?,
      lastCreditPaid: map['lastCreditPaid'] as num?,
      lastCreditFullyPaid: map['lastCreditFullyPaid'] as bool?,
      status: map['status'] as String?,
      role: map['role'] as String?,
      id: map['_id'] as String?,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
