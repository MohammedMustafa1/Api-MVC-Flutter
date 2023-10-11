class Shop {
  Shop({
      this.id, 
      this.isActive, 
      this.createdAt, 
      this.name, 
      this.description, 
      this.shopemail, 
      this.shopaddress, 
      this.shopcity, 
      this.userid, 
      this.image,});

  Shop.fromJson(dynamic json) {
    id = json['_id'];
    isActive = json['is_active'];
    createdAt = json['created_At'];
    name = json['name'];
    description = json['description'];
    shopemail = json['shopemail'];
    shopaddress = json['shopaddress'];
    shopcity = json['shopcity'];
    userid = json['userid'];
    image = json['image'];
  }
  String? id;
  bool? isActive;
  String? createdAt;
  String? name;
  String? description;
  String? shopemail;
  String? shopaddress;
  String? shopcity;
  String? userid;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['is_active'] = isActive;
    map['created_At'] = createdAt;
    map['name'] = name;
    map['description'] = description;
    map['shopemail'] = shopemail;
    map['shopaddress'] = shopaddress;
    map['shopcity'] = shopcity;
    map['userid'] = userid;
    map['image'] = image;
    return map;
  }

}