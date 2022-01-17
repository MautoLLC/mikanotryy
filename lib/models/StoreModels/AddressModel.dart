class Address {
  String? firstName;
  String? lastName;
  String? email;
  String? company;
  int? countryId;
  String? country;
  int? stateProvinceId;
  String? city;
  String? address1;
  String? address2;
  String? zipPostalCode;
  String? phoneNumber;
  String? faxNumber;
  String? customerAttributes;
  String? createdOnUtc;
  String? province;
  int? id;
  bool chosen = false;

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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
