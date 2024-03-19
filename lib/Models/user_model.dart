// To parse this JSON data, do
//
//     final vendor = vendorFromJson(jsonString);

import 'dart:convert';

List<Vendor> vendorFromJson(String str) => List<Vendor>.from(json.decode(str).map((x) => Vendor.fromJson(x)));

String vendorToJson(List<Vendor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vendor {
  String email;
  String password;
  String companyName;
  String companyAddress;
  String personName;
  String contact;

  Vendor({
    required this.email,
    required this.password,
    required this.companyName,
    required this.companyAddress,
    required this.personName,
    required this.contact,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    email: json["email"],
    password: json["password"],
    companyName: json["companyName"],
    companyAddress: json["companyAddress"],
    personName: json["personName"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "companyName": companyName,
    "companyAddress": companyAddress,
    "personName": personName,
    "contact": contact,
  };
}
