class RFQ {
  String? _name;
  String? _email;
  String? _phone;
  String? _address;
  String? _note;
  int? _productId;
  int? _customerId;
  int? _id;

  RFQ(
      {String? name,
      String? email,
      String? phone,
      String? address,
      String? note,
      int? productId,
      int? customerId,
      int? id}) {
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (address != null) {
      this._address = address;
    }
    if (note != null) {
      this._note = note;
    }
    if (productId != null) {
      this._productId = productId;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (id != null) {
      this._id = id;
    }
  }

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get email => _email;

  set email(String? email) => _email = email;

  String? get phone => _phone;

  set phone(String? phone) => _phone = phone;

  String? get address => _address;

  set address(String? address) => _address = address;

  String? get note => _note;

  set note(String? note) => _note = note;

  int? get productId => _productId;

  set productId(int? productId) => _productId = productId;

  int? get customerId => _customerId;

  set customerId(int? customerId) => _customerId = customerId;

  int? get id => _id;

  set id(int? id) => _id = id;

  RFQ.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _address = json['address'];
    _note = json['note'];
    _productId = json['product_id'];
    _customerId = json['customer_id'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['address'] = this._address;
    data['note'] = this._note;
    data['product_id'] = this._productId;
    data['customer_id'] = this._customerId;
    data['id'] = this._id;
    return data;
  }
}
