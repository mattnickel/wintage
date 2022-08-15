class ProductList {
  final List<Product> products;

  ProductList({
    this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {

    List<Product> products = new List<Product>();
    products = parsedJson.map((i)=>Product.fromJson(i)).toList();

    return new ProductList(
        products: products
    );
  }
}

class Product {
  int id;
  String name;
  int price;
  String description;
  String primaryImage;


   Product(
    {this.id,
    this.name,
    this.price,
    this.description,
      this.primaryImage,
    });

    Product.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      name = json['name'];
      price = json['price'];
      description = json['description'];
      primaryImage = json['primary_image'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['name'] = this.name;
      data['price'] = this.price;
      data['description'] = this.description;
      data['primary_image'] = this.primaryImage;
      return data;
    }
  }