import 'dart:convert';
import '../models/product.dart';

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final parsedList = parsed.map<Product>((json) => Product.fromJson(json))
      .toList();
  return parsedList;
}