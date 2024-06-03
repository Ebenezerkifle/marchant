import 'dart:convert';

class UserModel {
  // String? name;
  String? phoneNumber;
  String? password;
  String? categoryId;

  UserModel({
    // this.name,
    this.phoneNumber,
    this.password,
    this.categoryId,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
