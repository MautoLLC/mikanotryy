class Product {
  int id;
  String Name;
  double Price;
  String Description;
  String Image;
  String Code;
  String Category;
  int Rating;
  Product(
      {required this.Name,
      required this.Price,
      required this.Description,
      required this.Image,
      required this.Code,
      required this.Category,
      required this.Rating, this.id = 0});

  // From json
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        Name: json['name'],
        Price: json['price'],
        Description:
            json['full_description'] == null ? '' : json['full_description'],
        Image: json['images'].length == 0 ? '' : json['images'][0]['src'],
        Code: json['sku'] == null ? '' : json['sku'],
        Category: json['Category'] == null ? '' : json['Category'],
        Rating: json['approved_rating_sum']);
  }
}
