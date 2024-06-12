// To parse this JSON data, do
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  int? status;
  String? message;
  List<PrdItem?>? result;

  Products({
    required this.status,
    required this.message,
    required this.result,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    status: json["Status"],
    message: json["Message"],
    result: List<PrdItem>.from(json["Result"].map((x) => PrdItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": List<dynamic>.from(result!.map((x) => x?.toJson())),
  };
}

class PrdItem {
  String? name;
  String? priceCode;
  String? imageName;
  int? id;

  PrdItem({
    required this.name,
    required this.priceCode,
    required this.imageName,
    required this.id,
  });

  factory PrdItem.fromJson(Map<String, dynamic> json) => PrdItem(
    name: json["Name"],
    priceCode: json["PriceCode"],
    imageName: json["ImageName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "PriceCode": priceCode,
    "ImageName": imageName,
    "Id": id,
  };
}
