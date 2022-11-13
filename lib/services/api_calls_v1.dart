import 'dart:convert';

import 'package:wintage/models/product.dart';
import '../services/parse_json.dart';
import '../models/categories.dart';


Future<List<Product>> fetchProducts(client, category, context) async {

  Uri url = Uri.parse("http://localhost:3000/api/v1/products"+"?category=$category");
  print("Fetching from cache: $category");
  final response = await client.get(
      url, headers: {'content-type': 'application/json'}
  );

  if (response != null) {
    print("we have response");
    if (response.statusCode == 200) {
      print(response.body);
      return parseProducts(response.body);
    } else {

      return List.empty();
    }
  } else return List.empty();
}
Future<List<Category>>getCategories(client) async {
  Uri url = Uri.parse("http://localhost:3000/api/v1/categories");

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
  }else {
    return List.empty();
  }
}
