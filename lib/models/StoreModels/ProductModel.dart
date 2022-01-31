class Product {
  int id;
  String Name;
  double Price;
  String Description;
  String Image;
  String Code;
  String Category;
  int Rating;
  bool liked;
  Product(
      {required this.Name,
      required this.Price,
      required this.Description,
      required this.Image,
      required this.Code,
      required this.Category,
      required this.Rating,
      this.liked = false,
      this.id = 0});

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

  // To json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': Name,
      'price': Price,
      'full_description': Description,
      'images': [
        {'src': Image}
      ],
      'sku': Code,
      'Category': Category,
      'approved_rating_sum': Rating
    };
  }
}
