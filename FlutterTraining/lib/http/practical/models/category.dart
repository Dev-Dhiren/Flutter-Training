class Categories {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  Categories({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  Categories.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['creationAt'] = creationAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
