// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  String? id;
  String? name;
  List<Category>? subcategory;

  Category({this.id, this.name, this.subcategory});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subCategories': subcategory?.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      subcategory: map['subCategories'] != null
          ? List<Category>.from(
              (map['subCategories'] as List<dynamic>).map<Category?>(
                (x) => Category.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Category.fromJson(String source) =>
  //     Category.fromMap(json.decode(source) as Map<String, dynamic>);

  // static List<Category> listFromApi(List<dynamic> categories) {
  //   List<Category> list = [];
  //   for (var ele in categories) {
  //     Category c = Category.fromMap(ele);
  //     list.add(c);
  //   }
  //   return list;
  // }
}
