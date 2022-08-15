import 'dart:convert';

import 'package:wintage/models/product.dart';
import '../services/parse_json.dart';
import '../models/categories.dart';


Future<List<Product>> fetchProducts(client, category, context) async {

  var url = "http://localhost:3000/api/v1/products"+"?category=$category";
  print("Fetching from cache: $category");
  final response = await client.get(
      url, headers: {'content-type': 'application/json'}
  );

  if (response != null) {
    if (response.statusCode == 200) {
      print(response.body);
      return parseProducts(response.body);
    } else {

      return null;
    }
  } else return null;
}
Future<List<Category>>getCategories(client) async {
  var url = "http://localhost:3000/api/v1/categories";

  final response = await client.get(
      url, headers: {'content-type': 'application/json'}
  );
  print(response.body);
  if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    print(parsed);
    final parsedList = parsed.map<Category>((json) => Category.fromJson(json)).toList();
    print(parsedList);
    return parsedList;
  }else return null;
}
