class CartModel {
  int? customerId;
  String? workingAt;
  String? startTime;
  List<CartItems>? cartItems;

  CartModel({this.customerId, this.workingAt, this.startTime, this.cartItems});

  CartModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    workingAt = json['workingAt'];
    startTime = json['startTime'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['workingAt'] = workingAt;
    data['startTime'] = startTime;
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItems {
  int? taskDetailId;
  double? price;
  int? unit;
  int? quantity;

  CartItems({this.taskDetailId, this.price, this.unit, this.quantity});

  CartItems.fromJson(Map<String, dynamic> json) {
    taskDetailId = json['taskDetailId'];
    price = json['price'];
    unit = json['unit'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskDetailId'] = taskDetailId;
    data['price'] = price;
    data['unit'] = unit;
    data['quantity'] = quantity;
    return data;
  }
}
