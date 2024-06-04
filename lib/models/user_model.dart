import 'dart:convert';

import 'package:marchant/enums/user_role.dart';

class UserModel {
  // String? name;
  String? phoneNumber;
  String? password;
  String? categoryId;
  UserRole? userRole;

  UserModel({
    // this.name,
    this.phoneNumber,
    this.password,
    this.categoryId,
    this.userRole,
  });

  UserModel copywith({
    var phoneNumber,
    var password,
    var categoryId,
  }) {
    return UserModel()
      ..phoneNumber = phoneNumber ?? this.phoneNumber
      ..password = password ?? this.password
      ..categoryId = categoryId ?? categoryId;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'name': name,
      'password': password,
      'phoneNumber': phoneNumber,
      'CategoryId': categoryId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      // name: map['name'] != null ? map['name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      categoryId:
          map['CategoryId'] != null ? map['CategoryId'] as String : null,
      userRole: map['role'] != null
          ? //stringToUserRole[map['role']] ??
          UserRole.retailor
          : UserRole.retailor,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
