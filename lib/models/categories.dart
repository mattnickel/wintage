class CategoryList {
  final List<Category> categories;

  CategoryList({
    required this.categories,
  });

  factory CategoryList.fromJson(List<dynamic> parsedJson) {

    List<Category> categories = <Category>[];
    categories = parsedJson.map((i)=>Category.fromJson(i)).toList();

    return new CategoryList(
        categories: categories
    );

  }

}



class Category {
  late String name;

  Category({required this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}