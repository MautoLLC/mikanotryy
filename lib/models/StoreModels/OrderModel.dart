import 'package:mymikano_app/models/StoreModels/ProductModel.dart';

class Order {
  var storeId;
  bool? pickUpInStore;
  var paymentMethodSystemName;
  var customerCurrencyCode;
  var currencyRate;
  var customerTaxDisplayTypeId;
  var vatNumber;
  var orderSubtotalInclTax;
  var orderSubtotalExclTax;
  var orderSubTotalDiscountInclTax;
  var orderSubTotalDiscountExclTax;
  var orderShippingInclTax;
  var orderShippingExclTax;
  var paymentMethodAdditionalFeeInclTax;
  var paymentMethodAdditionalFeeExclTax;
  var taxRates;
  var orderTax;
  var orderDiscount;
  var orderTotal;
  var refundedAmount;
  bool? rewardPointsWereAdded;
  var checkoutAttributeDescription;
  var customerLanguageId;
  var affiliateId;
  var customerIp;
  var authorizationTransactionId;
  var authorizationTransactionCode;
  var authorizationTransactionResult;
  var captureTransactionId;
  var captureTransactionResult;
  var subscriptionTransactionId;
  var paidDateUtc;
  var shippingMethod;
  var shippingRateComputationMethodSystemName;
  var customValuesXml;
  bool? deleted;
  var createdOnUtc;
  var customerId;
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  List<OrderItems>? orderItems;
  var orderStatus;
  var paymentStatus;
  var shippingStatus;
  var customerTaxDisplayType;
  var id;

  Order(
      {this.storeId,
      this.pickUpInStore,
      this.paymentMethodSystemName,
      this.customerCurrencyCode,
      this.currencyRate,
      this.customerTaxDisplayTypeId,
      this.vatNumber,
      this.orderSubtotalInclTax,
      this.orderSubtotalExclTax,
      this.orderSubTotalDiscountInclTax,
      this.orderSubTotalDiscountExclTax,
      this.orderShippingInclTax,
      this.orderShippingExclTax,
      this.paymentMethodAdditionalFeeInclTax,
      this.paymentMethodAdditionalFeeExclTax,
      this.taxRates,
      this.orderTax,
      this.orderDiscount,
      this.orderTotal,
      this.refundedAmount,
      this.rewardPointsWereAdded,
      this.checkoutAttributeDescription,
      this.customerLanguageId,
      this.affiliateId,
      this.customerIp,
      this.authorizationTransactionId,
      this.authorizationTransactionCode,
      this.authorizationTransactionResult,
      this.captureTransactionId,
      this.captureTransactionResult,
      this.subscriptionTransactionId,
      this.paidDateUtc,
      this.shippingMethod,
      this.shippingRateComputationMethodSystemName,
      this.customValuesXml,
      this.deleted,
      this.createdOnUtc,
      this.customerId,
      this.billingAddress,
      this.shippingAddress,
      this.orderItems,
      this.orderStatus,
      this.paymentStatus,
      this.shippingStatus,
      this.customerTaxDisplayType,
      this.id});

  Order.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    pickUpInStore = json['pick_up_in_store'];
    paymentMethodSystemName = json['payment_method_system_name'];
    customerCurrencyCode = json['customer_currency_code'];
    currencyRate = json['currency_rate'];
    customerTaxDisplayTypeId = json['customer_tax_display_type_id'];
    vatNumber = json['vat_number'];
    orderSubtotalInclTax = json['order_subtotal_incl_tax'];
    orderSubtotalExclTax = json['order_subtotal_excl_tax'];
    orderSubTotalDiscountInclTax = json['order_sub_total_discount_incl_tax'];
    orderSubTotalDiscountExclTax = json['order_sub_total_discount_excl_tax'];
    orderShippingInclTax = json['order_shipping_incl_tax'];
    orderShippingExclTax = json['order_shipping_excl_tax'];
    paymentMethodAdditionalFeeInclTax =
        json['payment_method_additional_fee_incl_tax'];
    paymentMethodAdditionalFeeExclTax =
        json['payment_method_additional_fee_excl_tax'];
    taxRates = json['tax_rates'];
    orderTax = json['order_tax'];
    orderDiscount = json['order_discount'];
    orderTotal = json['order_total'];
    refundedAmount = json['refunded_amount'];
    rewardPointsWereAdded = json['reward_points_were_added'];
    checkoutAttributeDescription = json['checkout_attribute_description'];
    customerLanguageId = json['customer_language_id'];
    affiliateId = json['affiliate_id'];
    customerIp = json['customer_ip'];
    authorizationTransactionId = json['authorization_transaction_id'];
    authorizationTransactionCode = json['authorization_transaction_code'];
    authorizationTransactionResult = json['authorization_transaction_result'];
    captureTransactionId = json['capture_transaction_id'];
    captureTransactionResult = json['capture_transaction_result'];
    subscriptionTransactionId = json['subscription_transaction_id'];
    paidDateUtc = json['paid_date_utc'];
    shippingMethod = json['shipping_method'];
    shippingRateComputationMethodSystemName =
        json['shipping_rate_computation_method_system_name'];
    customValuesXml = json['custom_values_xml'];
    deleted = json['deleted'];
    createdOnUtc = json['created_on_utc'];
    customerId = json['customer_id'];
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? new BillingAddress.fromJson(json['shipping_address'])
        : null;
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    shippingStatus = json['shipping_status'];
    customerTaxDisplayType = json['customer_tax_display_type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['pick_up_in_store'] = this.pickUpInStore;
    data['payment_method_system_name'] = this.paymentMethodSystemName;
    data['customer_currency_code'] = this.customerCurrencyCode;
    data['currency_rate'] = this.currencyRate;
    data['customer_tax_display_type_id'] = this.customerTaxDisplayTypeId;
    data['vat_number'] = this.vatNumber;
    data['order_subtotal_incl_tax'] = this.orderSubtotalInclTax;
    data['order_subtotal_excl_tax'] = this.orderSubtotalExclTax;
    data['order_sub_total_discount_incl_tax'] =
        this.orderSubTotalDiscountInclTax;
    data['order_sub_total_discount_excl_tax'] =
        this.orderSubTotalDiscountExclTax;
    data['order_shipping_incl_tax'] = this.orderShippingInclTax;
    data['order_shipping_excl_tax'] = this.orderShippingExclTax;
    data['payment_method_additional_fee_incl_tax'] =
        this.paymentMethodAdditionalFeeInclTax;
    data['payment_method_additional_fee_excl_tax'] =
        this.paymentMethodAdditionalFeeExclTax;
    data['tax_rates'] = this.taxRates;
    data['order_tax'] = this.orderTax;
    data['order_discount'] = this.orderDiscount;
    data['order_total'] = this.orderTotal;
    data['refunded_amount'] = this.refundedAmount;
    data['reward_points_were_added'] = this.rewardPointsWereAdded;
    data['checkout_attribute_description'] = this.checkoutAttributeDescription;
    data['customer_language_id'] = this.customerLanguageId;
    data['affiliate_id'] = this.affiliateId;
    data['customer_ip'] = this.customerIp;
    data['authorization_transaction_id'] = this.authorizationTransactionId;
    data['authorization_transaction_code'] = this.authorizationTransactionCode;
    data['authorization_transaction_result'] =
        this.authorizationTransactionResult;
    data['capture_transaction_id'] = this.captureTransactionId;
    data['capture_transaction_result'] = this.captureTransactionResult;
    data['subscription_transaction_id'] = this.subscriptionTransactionId;
    data['paid_date_utc'] = this.paidDateUtc;
    data['shipping_method'] = this.shippingMethod;
    data['shipping_rate_computation_method_system_name'] =
        this.shippingRateComputationMethodSystemName;
    data['custom_values_xml'] = this.customValuesXml;
    data['deleted'] = this.deleted;
    data['created_on_utc'] = this.createdOnUtc;
    data['customer_id'] = this.customerId;
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['order_status'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['shipping_status'] = this.shippingStatus;
    data['customer_tax_display_type'] = this.customerTaxDisplayType;
    data['id'] = this.id;
    return data;
  }
}

class BillingAddress {
  var firstName;
  var lastName;
  var email;
  var company;
  var countryId;
  var country;
  var stateProvinceId;
  var city;
  var address1;
  var address2;
  var zipPostalCode;
  var phoneNumber;
  var faxNumber;
  var customerAttributes;
  var createdOnUtc;
  var province;
  var id;

  BillingAddress(
      {this.firstName,
      this.lastName,
      this.email,
      this.company,
      this.countryId,
      this.country,
      this.stateProvinceId,
      this.city,
      this.address1,
      this.address2,
      this.zipPostalCode,
      this.phoneNumber,
      this.faxNumber,
      this.customerAttributes,
      this.createdOnUtc,
      this.province,
      this.id});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    company = json['company'];
    countryId = json['country_id'];
    country = json['country'];
    stateProvinceId = json['state_province_id'];
    city = json['city'];
    address1 = json['address1'];
    address2 = json['address2'];
    zipPostalCode = json['zip_postal_code'];
    phoneNumber = json['phone_number'];
    faxNumber = json['fax_number'];
    customerAttributes = json['customer_attributes'];
    createdOnUtc = json['created_on_utc'];
    province = json['province'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['company'] = this.company;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['state_province_id'] = this.stateProvinceId;
    data['city'] = this.city;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['zip_postal_code'] = this.zipPostalCode;
    data['phone_number'] = this.phoneNumber;
    data['fax_number'] = this.faxNumber;
    data['customer_attributes'] = this.customerAttributes;
    data['created_on_utc'] = this.createdOnUtc;
    data['province'] = this.province;
    data['id'] = this.id;
    return data;
  }
}

class OrderItems {
  List<ProductAttributes>? productAttributes;
  var quantity;
  var unitPriceInclTax;
  var unitPriceExclTax;
  var priceInclTax;
  var priceExclTax;
  var discountAmountInclTax;
  var discountAmountExclTax;
  var originalProductCost;
  var attributeDescription;
  var downloadCount;
  bool? isDownloadActivated;
  var licenseDownloadId;
  var itemWeight;
  var rentalStartDateUtc;
  var rentalEndDateUtc;
  Product? product;
  var productId;
  var id;

  OrderItems(
      {this.productAttributes,
      this.quantity,
      this.unitPriceInclTax,
      this.unitPriceExclTax,
      this.priceInclTax,
      this.priceExclTax,
      this.discountAmountInclTax,
      this.discountAmountExclTax,
      this.originalProductCost,
      this.attributeDescription,
      this.downloadCount,
      this.isDownloadActivated,
      this.licenseDownloadId,
      this.itemWeight,
      this.rentalStartDateUtc,
      this.rentalEndDateUtc,
      this.product,
      this.productId,
      this.id});

  OrderItems.fromJson(Map<String, dynamic> json) {
    if (json['product_attributes'] != null) {
      productAttributes = <ProductAttributes>[];
      json['product_attributes'].forEach((v) {
        productAttributes!.add(new ProductAttributes.fromJson(v));
      });
    }
    quantity = json['quantity'];
    unitPriceInclTax = json['unit_price_incl_tax'];
    unitPriceExclTax = json['unit_price_excl_tax'];
    priceInclTax = json['price_incl_tax'];
    priceExclTax = json['price_excl_tax'];
    discountAmountInclTax = json['discount_amount_incl_tax'];
    discountAmountExclTax = json['discount_amount_excl_tax'];
    originalProductCost = json['original_product_cost'];
    attributeDescription = json['attribute_description'];
    downloadCount = json['download_count'];
    isDownloadActivated = json['isDownload_activated'];
    licenseDownloadId = json['license_download_id'];
    itemWeight = json['item_weight'];
    rentalStartDateUtc = json['rental_start_date_utc'];
    rentalEndDateUtc = json['rental_end_date_utc'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    productId = json['product_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productAttributes != null) {
      data['product_attributes'] =
          this.productAttributes!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['unit_price_incl_tax'] = this.unitPriceInclTax;
    data['unit_price_excl_tax'] = this.unitPriceExclTax;
    data['price_incl_tax'] = this.priceInclTax;
    data['price_excl_tax'] = this.priceExclTax;
    data['discount_amount_incl_tax'] = this.discountAmountInclTax;
    data['discount_amount_excl_tax'] = this.discountAmountExclTax;
    data['original_product_cost'] = this.originalProductCost;
    data['attribute_description'] = this.attributeDescription;
    data['download_count'] = this.downloadCount;
    data['isDownload_activated'] = this.isDownloadActivated;
    data['license_download_id'] = this.licenseDownloadId;
    data['item_weight'] = this.itemWeight;
    data['rental_start_date_utc'] = this.rentalStartDateUtc;
    data['rental_end_date_utc'] = this.rentalEndDateUtc;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['product_id'] = this.productId;
    data['id'] = this.id;
    return data;
  }
}

class ProductAttributes {
  var value;
  var id;

  ProductAttributes({this.value, this.id});

  ProductAttributes.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['id'] = this.id;
    return data;
  }
}

class Images {
  var id;
  var pictureId;
  var position;
  var src;
  var attachment;

  Images({this.id, this.pictureId, this.position, this.src, this.attachment});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureId = json['picture_id'];
    position = json['position'];
    src = json['src'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['picture_id'] = this.pictureId;
    data['position'] = this.position;
    data['src'] = this.src;
    data['attachment'] = this.attachment;
    return data;
  }
}

class Attributes {
  var productAttributeId;
  var productAttributeName;
  var textPrompt;
  bool? isRequired;
  var attributeControlTypeId;
  var displayOrder;
  var defaultValue;
  var attributeControlTypeName;
  List<AttributeValues>? attributeValues;
  var id;

  Attributes(
      {this.productAttributeId,
      this.productAttributeName,
      this.textPrompt,
      this.isRequired,
      this.attributeControlTypeId,
      this.displayOrder,
      this.defaultValue,
      this.attributeControlTypeName,
      this.attributeValues,
      this.id});

  Attributes.fromJson(Map<String, dynamic> json) {
    productAttributeId = json['product_attribute_id'];
    productAttributeName = json['product_attribute_name'];
    textPrompt = json['text_prompt'];
    isRequired = json['is_required'];
    attributeControlTypeId = json['attribute_control_type_id'];
    displayOrder = json['display_order'];
    defaultValue = json['default_value'];
    attributeControlTypeName = json['attribute_control_type_name'];
    if (json['attribute_values'] != null) {
      attributeValues = <AttributeValues>[];
      json['attribute_values'].forEach((v) {
        attributeValues!.add(new AttributeValues.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_attribute_id'] = this.productAttributeId;
    data['product_attribute_name'] = this.productAttributeName;
    data['text_prompt'] = this.textPrompt;
    data['is_required'] = this.isRequired;
    data['attribute_control_type_id'] = this.attributeControlTypeId;
    data['display_order'] = this.displayOrder;
    data['default_value'] = this.defaultValue;
    data['attribute_control_type_name'] = this.attributeControlTypeName;
    if (this.attributeValues != null) {
      data['attribute_values'] =
          this.attributeValues!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class AttributeValues {
  var typeId;
  var associatedProductId;
  var name;
  var colorSquaresRgb;
  ImageSquaresImage? imageSquaresImage;
  var priceAdjustment;
  var weightAdjustment;
  var cost;
  var quantity;
  bool? isPreSelected;
  var displayOrder;
  var productImageId;
  var type;
  var id;

  AttributeValues(
      {this.typeId,
      this.associatedProductId,
      this.name,
      this.colorSquaresRgb,
      this.imageSquaresImage,
      this.priceAdjustment,
      this.weightAdjustment,
      this.cost,
      this.quantity,
      this.isPreSelected,
      this.displayOrder,
      this.productImageId,
      this.type,
      this.id});

  AttributeValues.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    associatedProductId = json['associated_product_id'];
    name = json['name'];
    colorSquaresRgb = json['color_squares_rgb'];
    imageSquaresImage = json['image_squares_image'] != null
        ? new ImageSquaresImage.fromJson(json['image_squares_image'])
        : null;
    priceAdjustment = json['price_adjustment'];
    weightAdjustment = json['weight_adjustment'];
    cost = json['cost'];
    quantity = json['quantity'];
    isPreSelected = json['is_pre_selected'];
    displayOrder = json['display_order'];
    productImageId = json['product_image_id'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['associated_product_id'] = this.associatedProductId;
    data['name'] = this.name;
    data['color_squares_rgb'] = this.colorSquaresRgb;
    if (this.imageSquaresImage != null) {
      data['image_squares_image'] = this.imageSquaresImage!.toJson();
    }
    data['price_adjustment'] = this.priceAdjustment;
    data['weight_adjustment'] = this.weightAdjustment;
    data['cost'] = this.cost;
    data['quantity'] = this.quantity;
    data['is_pre_selected'] = this.isPreSelected;
    data['display_order'] = this.displayOrder;
    data['product_image_id'] = this.productImageId;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}

class ImageSquaresImage {
  var src;
  var attachment;

  ImageSquaresImage({this.src, this.attachment});

  ImageSquaresImage.fromJson(Map<String, dynamic> json) {
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

class ProductAttributeCombinations {
  var productId;
  var attributesXml;
  var stockQuantity;
  var sku;
  var manufacturerPartNumber;
  var gtin;
  var overriddenPrice;
  var pictureId;
  var id;

  ProductAttributeCombinations(
      {this.productId,
      this.attributesXml,
      this.stockQuantity,
      this.sku,
      this.manufacturerPartNumber,
      this.gtin,
      this.overriddenPrice,
      this.pictureId,
      this.id});

  ProductAttributeCombinations.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributesXml = json['attributes_xml'];
    stockQuantity = json['stock_quantity'];
    sku = json['sku'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    gtin = json['gtin'];
    overriddenPrice = json['overridden_price'];
    pictureId = json['picture_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['attributes_xml'] = this.attributesXml;
    data['stock_quantity'] = this.stockQuantity;
    data['sku'] = this.sku;
    data['manufacturer_part_number'] = this.manufacturerPartNumber;
    data['gtin'] = this.gtin;
    data['overridden_price'] = this.overriddenPrice;
    data['picture_id'] = this.pictureId;
    data['id'] = this.id;
    return data;
  }
}

class ProductSpecificationAttributes {
  var productId;
  var attributeTypeId;
  var specificationAttributeOptionId;
  var customValue;
  bool? allowFiltering;
  bool? showOnProductPage;
  var displayOrder;
  var attributeType;
  SpecificationAttributeOption? specificationAttributeOption;
  var id;

  ProductSpecificationAttributes(
      {this.productId,
      this.attributeTypeId,
      this.specificationAttributeOptionId,
      this.customValue,
      this.allowFiltering,
      this.showOnProductPage,
      this.displayOrder,
      this.attributeType,
      this.specificationAttributeOption,
      this.id});

  ProductSpecificationAttributes.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributeTypeId = json['attribute_type_id'];
    specificationAttributeOptionId = json['specification_attribute_option_id'];
    customValue = json['custom_value'];
    allowFiltering = json['allow_filtering'];
    showOnProductPage = json['show_on_product_page'];
    displayOrder = json['display_order'];
    attributeType = json['attribute_type'];
    specificationAttributeOption =
        json['specification_attribute_option'] != null
            ? new SpecificationAttributeOption.fromJson(
                json['specification_attribute_option'])
            : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['attribute_type_id'] = this.attributeTypeId;
    data['specification_attribute_option_id'] =
        this.specificationAttributeOptionId;
    data['custom_value'] = this.customValue;
    data['allow_filtering'] = this.allowFiltering;
    data['show_on_product_page'] = this.showOnProductPage;
    data['display_order'] = this.displayOrder;
    data['attribute_type'] = this.attributeType;
    if (this.specificationAttributeOption != null) {
      data['specification_attribute_option'] =
          this.specificationAttributeOption!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class SpecificationAttributeOption {
  var specificationAttributeId;
  var name;
  var colorSquaresRgb;
  var displayOrder;
  var id;

  SpecificationAttributeOption(
      {this.specificationAttributeId,
      this.name,
      this.colorSquaresRgb,
      this.displayOrder,
      this.id});

  SpecificationAttributeOption.fromJson(Map<String, dynamic> json) {
    specificationAttributeId = json['specification_attribute_id'];
    name = json['name'];
    colorSquaresRgb = json['color_squares_rgb'];
    displayOrder = json['display_order'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specification_attribute_id'] = this.specificationAttributeId;
    data['name'] = this.name;
    data['color_squares_rgb'] = this.colorSquaresRgb;
    data['display_order'] = this.displayOrder;
    data['id'] = this.id;
    return data;
  }
}
