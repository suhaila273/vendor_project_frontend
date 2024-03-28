// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String id;
  String productName;
  String price;
  String discount;
  String discountPrice;
  String shortDesc;
  String longDesc;
  String vendorId;
  String categoryId;
  String videoLink;
  String stock;
  String quantity;
  String fssai;
  String productImg;
  int v;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.shortDesc,
    required this.longDesc,
    required this.vendorId,
    required this.categoryId,
    required this.videoLink,
    required this.stock,
    required this.quantity,
    required this.fssai,
    required this.productImg,
    required this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productName: json["product_name"],
    price: json["price"],
    discount: json["discount"],
    discountPrice: json["discount_price"],
    shortDesc: json["short_desc"],
    longDesc: json["long_desc"],
    vendorId: json["vendor_id"],
    categoryId: json["category_id"],
    videoLink: json["video_link"],
    stock: json["stock"],
    quantity: json["quantity"],
    fssai: json["fssai"],
    productImg: json["product_img"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_name": productName,
    "price": price,
    "discount": discount,
    "discount_price": discountPrice,
    "short_desc": shortDesc,
    "long_desc": longDesc,
    "vendor_id": vendorId,
    "category_id": categoryId,
    "video_link": videoLink,
    "stock": stock,
    "quantity": quantity,
    "fssai": fssai,
    "product_img": productImg,
    "__v": v,
  };
}
