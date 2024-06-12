// To parse this JSON data, do
//     final sbCategory = sbCategoryFromJson(jsonString);

import 'dart:convert';

SbCategory sbCategoryFromJson(String str) => SbCategory.fromJson(json.decode(str));

String sbCategoryToJson(SbCategory data) => json.encode(data.toJson());

class SbCategory {
  int? status;
  String? message;
  Result? result;

  SbCategory({
    required this.status,
    required this.message,
    required this.result,
  });

  factory SbCategory.fromJson(Map<String, dynamic> json) => SbCategory(
    status: json["Status"],
    message: json["Message"],
    result: Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": result?.toJson(),
  };
}

class Result {
  List<Category> category;

  Result({
    required this.category,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    category: List<Category>.from(json["Category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  int? isAuthorize;
  int? update080819;
  int? update130919;
  List<SubCategory>? subCategories;

  Category({
    required this.id,
    required this.name,
    this.isAuthorize,
    required this.update080819,
    required this.update130919,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["Id"],
    name: json["Name"],
    isAuthorize: json["IsAuthorize"],
    update080819: json["Update080819"],
    update130919: json["Update130919"],
    subCategories: json["SubCategories"] == null ? [] : List<SubCategory>.from(json["SubCategories"]!.map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "IsAuthorize": isAuthorize,
    "Update080819": update080819,
    "Update130919": update130919,
    "SubCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}

class SubCategory {
  int? id;
  String? name;
  List<Product>? product;

  SubCategory({
    required this.id,
    required this.name,
    required this.product,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["Id"],
    name: json["Name"],
    product: List<Product>.from(json["Product"].map((x) => Product?.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Product": List<dynamic>.from(product!.map((x) => x.toJson())),
  };
}

class Product {
  String? name;
  PriceCode? priceCode;
  String? imageName;
  int? id;

  Product({
    required this.name,
    required this.priceCode,
    required this.imageName,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["Name"],
    priceCode: priceCodeValues?.map[json["PriceCode"]],
    imageName: json["ImageName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "PriceCode": priceCodeValues.reverse?[priceCode],
    "ImageName": imageName,
    "Id": id,
  };
}

enum PriceCode {
  E39,
  E58,
  G30,
  I59
}

final priceCodeValues = EnumValues({
  "E39": PriceCode.E39,
  "E58": PriceCode.E58,
  "G30": PriceCode.G30,
  "I59": PriceCode.I59
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
