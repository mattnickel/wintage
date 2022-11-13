class ProductList {
  final List<Product> products;

  ProductList({
    required this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {

    List<Product> products = <Product>[];
    products = parsedJson.map((i)=>Product.fromJson(i)).toList();

    return new ProductList(
        products: products
    );
  }
}

class Product {
  late int id;
  late String name;
  late int price;

  late String primaryImage;
  // late bool myFavorite;


   Product(
    {required this.id,
    required this.name,
    required this.price,
    // required this.description,
    required this.primaryImage,
    // required this.myFavorite,
    });

    Product.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      name = json['name'];
      price = json['price'];
      // description = json['description'];
      primaryImage = json['primary_image'];
      // myFavorite = json['my_favorite'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['name'] = this.name;
      data['price'] = this.price;
      // data['description'] = this.description;
      data['primary_image'] = this.primaryImage;
      // data['my_favorite'] = this.myFavorite;
      return data;
    }
  }