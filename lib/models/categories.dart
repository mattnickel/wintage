class CategoryList {
  final List<Category> categories;

  CategoryList({
    this.categories,
  });

  factory CategoryList.fromJson(List<dynamic> parsedJson) {

    List<Category> categories = new List<Category>();
    categories = parsedJson.map((i)=>Category.fromJson(i)).toList();

    return new CategoryList(
        categories: categories
    );

  }

}



class Category {
  String name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}