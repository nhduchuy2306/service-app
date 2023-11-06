class OrderDetail {
  int? id;
  int? orderId;
  int? taskDetailId;
  String? taskDetailName;
  int? quantity;

  OrderDetail(
      {this.id,
      this.orderId,
      this.taskDetailId,
      this.taskDetailName,
      this.quantity});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    taskDetailId = json['taskDetailId'];
    taskDetailName = json['taskDetailName'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderId'] = orderId;
    data['taskDetailId'] = taskDetailId;
    data['taskDetailName'] = taskDetailName;
    data['quantity'] = quantity;
    return data;
  }
}
