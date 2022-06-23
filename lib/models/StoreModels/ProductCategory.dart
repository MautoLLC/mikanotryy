class ProductCategory {
  String? name;
  String? description;
  int? categoryTemplateId;
  String? metaKeywords;
  String? metaDescription;
  String? metaTitle;
  int? parentCategoryId;
  int? pageSize;
  String? pageSizeOptions;
  String? priceRanges;
  bool? showOnHomePage;
  bool? includeInTopMenu;
  bool? hasDiscountsApplied;
  bool? published;
  bool? deleted;
  int? displayOrder;
  String? createdOnUtc;
  String? updatedOnUtc;
  List<int>? roleIds;
  List<int>? discountIds;
  List<int>? storeIds;
  Image? image;
  String? seName;
  int? id;

  ProductCategory(
      {this.name,
      this.description,
      this.categoryTemplateId,
      this.metaKeywords,
      this.metaDescription,
      this.metaTitle,
      this.parentCategoryId,
      this.pageSize,
      this.pageSizeOptions,
      this.priceRanges,
      this.showOnHomePage,
      this.includeInTopMenu,
      this.hasDiscountsApplied,
      this.published,
      this.deleted,
      this.displayOrder,
      this.createdOnUtc,
      this.updatedOnUtc,
      this.roleIds,
      this.discountIds,
      this.storeIds,
      this.image,
      this.seName,
      this.id});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    categoryTemplateId = json['category_template_id'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    metaTitle = json['meta_title'];
    parentCategoryId = json['parent_category_id'];
    pageSize = json['page_size'];
    pageSizeOptions = json['page_size_options'];
    priceRanges = json['price_ranges'];
    showOnHomePage = json['show_on_home_page'];
    includeInTopMenu = json['include_in_top_menu'];
    hasDiscountsApplied = json['has_discounts_applied'];
    published = json['published'];
    deleted = json['deleted'];
    displayOrder = json['display_order'];
    createdOnUtc = json['created_on_utc'];
    updatedOnUtc = json['updated_on_utc'];
    roleIds = json['role_ids'].cast<int>();
    discountIds = json['discount_ids'].cast<int>();
    storeIds = json['store_ids'].cast<int>();
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    seName = json['se_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_template_id'] = this.categoryTemplateId;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['meta_title'] = this.metaTitle;
    data['parent_category_id'] = this.parentCategoryId;
    data['page_size'] = this.pageSize;
    data['page_size_options'] = this.pageSizeOptions;
    data['price_ranges'] = this.priceRanges;
    data['show_on_home_page'] = this.showOnHomePage;
    data['include_in_top_menu'] = this.includeInTopMenu;
    data['has_discounts_applied'] = this.hasDiscountsApplied;
    data['published'] = this.published;
    data['deleted'] = this.deleted;
    data['display_order'] = this.displayOrder;
    data['created_on_utc'] = this.createdOnUtc;
    data['updated_on_utc'] = this.updatedOnUtc;
    data['role_ids'] = this.roleIds;
    data['discount_ids'] = this.discountIds;
    data['store_ids'] = this.storeIds;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['se_name'] = this.seName;
    data['id'] = this.id;
    return data;
  }
}

class Image {
  String? src;
  String? attachment;

  Image({this.src, this.attachment});

  Image.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['attachment'] = this.attachment;
    return data;
  }
}
