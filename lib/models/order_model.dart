class Order {
  int? id;
  String? createdAt;
  String? workingAt;
  String? startTime;
  String? endTime;
  String? address;
  String? categoryName;
  int? state;
  int? paymentStatus;
  double? total;
  bool? status;
  int? customerId;

  Order(
      {this.id,
      this.createdAt,
      this.workingAt,
      this.startTime,
      this.endTime,
      this.address,
      this.categoryName,
      this.state,
      this.paymentStatus,
      this.total,
      this.status,
      this.customerId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    workingAt = json['workingAt'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    address = json['address'];
    categoryName = json['categoryName'];
    state = json['state'];
    paymentStatus = json['paymentStatus'];
    total = json['total'];
    status = json['status'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['workingAt'] = workingAt;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['address'] = address;
    data['categoryName'] = categoryName;
    data['state'] = state;
    data['paymentStatus'] = paymentStatus;
    data['total'] = total;
    data['status'] = status;
    data['customerId'] = customerId;
    return data;
  }
}
