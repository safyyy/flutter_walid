import 'dart:convert';

import 'package:http/http.dart' as http;

import '../product.dart';



class ProductApi{
  Future<List<Product>?> getAllProducts() async{
    var client =http.Client();
    var uri=Uri.parse("http://192.168.1.14:8000/api/all/");
    var response =await client.get(uri);
    if (response.statusCode==200){
      var json =response.body;
      return productFromJson(json);
    }
   

  }
Future<Product> addProduct(int id, String libele, int stock, double price, String photo, DateTime fabricationDate, DateTime expirationDate) async {
  var client = http.Client();
  var uri = Uri.parse("http://192.168.1.14:8000/api/add/");

  final http.Response response = await client.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'id': id,
      'libele': libele,
      'stock': stock,
      'price': price,
      'photo': photo,
      'datefab': fabricationDate.toIso8601String(),
      'dateexp': expirationDate.toIso8601String(),
    }),
  );

  if (response.statusCode == 200) {
    var json = response.body;
    return Product.fromJson(jsonDecode(json));
  } else {
    throw Exception('Failed to save user');
  }
}
}


