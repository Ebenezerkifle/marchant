import 'dart:convert';

class UserModel {
  // String? name;
  String? phoneNumber;
  String? password;
  String? CategoryId;

  UserModel({
    // this.name,
    this.phoneNumber,
    this.password,
    this.CategoryId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'name': name,
      'password': password,
      'phoneNumber': phoneNumber,
      'CategoryId': CategoryId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      // name: map['name'] != null ? map['name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      CategoryId:
          map['CategoryId'] != null ? map['CategoryId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
