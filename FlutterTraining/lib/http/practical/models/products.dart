import 'package:flutter_training/http/practical/models/category.dart';

class Products {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  Categories? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  Products({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category =
        json['category'] != null ? Categories.fromJson(json['category']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['price'] = price;
    map['description'] = description;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['images'] = images;
    map['creationAt'] = creationAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
