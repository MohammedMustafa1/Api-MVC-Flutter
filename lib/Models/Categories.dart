class Categories {
  Categories({
      this.id, 
      this.type, 
      this.salePercent, 
      this.date, 
      this.name, 
      this.image,});

  Categories.fromJson(dynamic json) {
    id = json['_id'];
    type = json['type'];
    salePercent = json['sale_percent'];
    date = json['date'];
    name = json['name'];
    image = json['image'];
  }
  String? id;
  String? type;
  int? salePercent;
  String? date;
  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['type'] = type;
    map['sale_percent'] = salePercent;
    map['date'] = date;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}