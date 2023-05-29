// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    final int id;
    final String libele;
    final int stock;
    final double price;
    final String photo;
    final DateTime fabricationDate;
    final DateTime expirationDate;

    Product({
        required this.id,
        required this.libele,
        required this.stock,
        required this.price,
        required this.photo,
        required this.fabricationDate,
        required this.expirationDate,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        libele: json["libele"],
        stock: json["stock"],
        price: json["price"],
        photo: json["photo"],
        fabricationDate: DateTime.parse(json["fabricationDate"]),
        expirationDate: DateTime.parse(json["expirationDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "libele": libele,
        "stock": stock,
        "price": price,
        "photo": photo,
        "fabricationDate": "${fabricationDate.year.toString().padLeft(4, '0')}-${fabricationDate.month.toString().padLeft(2, '0')}-${fabricationDate.day.toString().padLeft(2, '0')}",
        "expirationDate": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
    };

    @override
    String toString(){
      String result=libele;
      return result;
    }
}
