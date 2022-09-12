import 'package:mymikano_app/utils/appsettings.dart';

class Product {
  int id;
  String Name;
  double Price;
  String Description;
  String Image;
  String Code;
  String Category;
  int Rating;
  String dataSheet;
  String dataSheetLabel;
  bool liked;
  bool isTopDeal;
  bool call_for_price;

  Product(
      {required this.Name,
      required this.Price,
      required this.Description,
      required this.Image,
      required this.Code,
      required this.Category,
      required this.Rating,
      this.liked = false,
      this.dataSheet = "",
      this.dataSheetLabel = "",
      this.id = 0,
      this.isTopDeal = false,
      this.call_for_price = false});

  // From json
  factory Product.fromJson(Map<String, dynamic> json) {
    String temp =
        json['full_description'] == null ? '' : json['full_description'];
    String data_Sheet = '';
    String dataSheetLabel = "";
    String full_description = temp;
    if (temp.contains("href")) {
      List<String> listsplit = temp.split("<a");
      full_description = listsplit[0].split("<p>")[1].replaceAll("&nbsp;", " ");

      data_Sheet = MikanoShopMainURl.replaceFirst("/api", "") +
          listsplit[1].split('"')[1];
      dataSheetLabel = listsplit[1].split('"')[2].substring(
          listsplit[1].split('"')[2].indexOf('>') + 1,
          listsplit[1].split('"')[2].indexOf('</a>'));
    }
    double price =
        double.parse(double.parse(json['price'].toString()).toStringAsFixed(2));
    return Product(
        id: json['id'],
        Name: json['name'],
        Price: price,
        Description: full_description,
        Image: json['images'].length == 0 ? '' : json['images'][0]['src'],
        Code: json['sku'] == null ? '' : json['sku'],
        Category: json['Category'] == null ? '' : json['Category'],
        dataSheet: data_Sheet,
        dataSheetLabel: dataSheetLabel,
        Rating: json['approved_rating_sum'],
        isTopDeal: json['is_top_deal'],
        call_for_price: json['call_for_price']);
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
      'approved_rating_sum': Rating,
      'call_for_price': call_for_price
    };
  }
}
