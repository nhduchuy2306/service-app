class Customer {
  int? id;
  String? name;
  String? email;
  String? address;
  bool? status;
  int? accountId;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.status,
      this.accountId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    status = json['status'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['status'] = status;
    data['accountId'] = accountId;
    return data;
  }
}
