// ignore_for_file: public_member_api_docs, sort_constructors_first

class Category {
  String? id;
  String? name;
  String? image;
  List<Category>? subcategory;

  Category({this.id, this.name, this.subcategory, this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'subCategories': subcategory?.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'] != null ? map['_id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
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
}
