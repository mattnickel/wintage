import 'dart:convert';
import '../models/product.dart';

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  print("good");
  final parsedList = parsed.map<Product>((json) => Product.fromJson(json))
      .toList();
  print("still ok?");
  print(parsedList);
  return parsedList;
}