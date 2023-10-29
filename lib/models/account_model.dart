class Account {
  int? id;
  String? phoneNumber;
  String? role;
  int? balance;
  String? createdAt;
  String? updatedAt;
  bool? status;

  Account(
      {this.id,
      this.phoneNumber,
      this.role,
      this.balance,
      this.createdAt,
      this.updatedAt,
      this.status});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    balance = json['balance'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['role'] = this.role;
    data['balance'] = this.balance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
