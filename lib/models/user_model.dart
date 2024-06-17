import 'dart:convert';

class UserModel {
  // String? name;
  String? phoneNumber;
  String? password;
  String? CategoryId;
  final int? transactionAmount;
  final int? creditAvailable;
  final int? tookCredit;
  final int? lastCreditPaid;
  final bool? lastCreditFullyPaid;
  final String? status;
  final String? role;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    // this.name,
    this.phoneNumber,
    this.password,
    this.CategoryId,
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
      // 'name': name,
      'password': password,
      'phoneNumber': phoneNumber,
      'CategoryId': CategoryId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
  // print("Mapping UserModel from map: $map");
  return UserModel(
    phoneNumber: map['phoneNumber'] as String?,
    password: map['password'] as String?,
    CategoryId: map['CategoryId'] as String?,
    transactionAmount: map['transactionAmount'] as int?,
    creditAvailable: map['creditAvailable'] as int?,
    tookCredit: map['tookCredit'] as int?,
    lastCreditPaid: map['lastCreditPaid'] as int?,
    lastCreditFullyPaid: map['lastCreditFullyPaid'] as bool?,
    status: map['status'] as String?,
    role: map['role'] as String?,
    id: map['_id'] as String?,
    createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
  );
}


  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
