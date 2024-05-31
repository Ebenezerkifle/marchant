// To parse this JSON data, do
//
//     final allCategories = allCategoriesFromJson(jsonString);

import 'dart:convert';

AllCategories allCategoriesFromJson(String str) =>
    AllCategories.fromJson(json.decode(str));

String allCategoriesToJson(AllCategories data) => json.encode(data.toJson());

class AllCategories {
  String status;
  int results;
  Data data;

  AllCategories({
    required this.status,
    required this.results,
    required this.data,
  });

  factory AllCategories.fromJson(Map<String, dynamic> json) => AllCategories(
        status: json["status"],
        results: json["results"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data.toJson(),
      };
}

class Data {
  List<Category> categories;

  Data({
    required this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String id;
  String name;
  String businessCategory;
  int v;
  List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.businessCategory,
    required this.v,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        businessCategory: json["businessCategory"],
        v: json["__v"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "businessCategory": businessCategory,
        "__v": v,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };
}

class SubCategory {
  String name;
  List<SubSubCategory> subSubCategories;
  String id;

  SubCategory({
    required this.name,
    required this.subSubCategories,
    required this.id,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        subSubCategories: List<SubSubCategory>.from(
            json["subSubCategories"].map((x) => SubSubCategory.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subSubCategories":
            List<dynamic>.from(subSubCategories.map((x) => x.toJson())),
        "_id": id,
      };
}

class SubSubCategory {
  String name;
  String id;

  SubSubCategory({
    required this.name,
    required this.id,
  });

  factory SubSubCategory.fromJson(Map<String, dynamic> json) => SubSubCategory(
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
      };
}
