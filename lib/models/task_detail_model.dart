class TaskDetail {
  int? id;
  String? name;
  int? price;
  int? duration;
  int? unit;
  int? quantity;
  String? description;
  bool? status;
  int? categoryId;

  TaskDetail(
      {this.id,
      this.name,
      this.price,
      this.duration,
      this.unit,
      this.quantity,
      this.description,
      this.status,
      this.categoryId});

  TaskDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
    unit = json['unit'];
    quantity = json['quantity'];
    description = json['description'];
    status = json['status'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['duration'] = duration;
    data['unit'] = unit;
    data['quantity'] = quantity;
    data['description'] = description;
    data['status'] = status;
    data['categoryId'] = categoryId;
    return data;
  }
}
