class Currency {
  String? name;
  String? currencyCode;
  double? rate;
  String? displayLocale;
  String? customFormatting;
  bool? limitedToStores;
  bool? published;
  int? displayOrder;
  String? createdOnUtc;
  String? updatedOnUtc;
  String? roundingType;
  List<int>? storeIds;
  int? id;

  Currency(
      {this.name,
      this.currencyCode,
      this.rate,
      this.displayLocale,
      this.customFormatting,
      this.limitedToStores,
      this.published,
      this.displayOrder,
      this.createdOnUtc,
      this.updatedOnUtc,
      this.roundingType,
      this.storeIds,
      this.id});

  Currency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currencyCode = json['currency_code'];
    rate = json['rate'];
    displayLocale = json['display_locale'];
    customFormatting = json['custom_formatting'];
    limitedToStores = json['limited_to_stores'];
    published = json['published'];
    displayOrder = json['display_order'];
    createdOnUtc = json['created_on_utc'];
    updatedOnUtc = json['updated_on_utc'];
    roundingType = json['rounding_type'];
    storeIds = json['store_ids'].cast<int>();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['currency_code'] = this.currencyCode;
    data['rate'] = this.rate;
    data['display_locale'] = this.displayLocale;
    data['custom_formatting'] = this.customFormatting;
    data['limited_to_stores'] = this.limitedToStores;
    data['published'] = this.published;
    data['display_order'] = this.displayOrder;
    data['created_on_utc'] = this.createdOnUtc;
    data['updated_on_utc'] = this.updatedOnUtc;
    data['rounding_type'] = this.roundingType;
    data['store_ids'] = this.storeIds;
    data['id'] = this.id;
    return data;
  }
}
