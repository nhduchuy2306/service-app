import 'dart:ffi';

class RegisterModel {
  String? phoneNumber;
  String? password;
  String? email;
  String? name;
  String? address;
  bool? status;

  RegisterModel({this.phoneNumber, this.password, this.email, this.name, this.address, this.status});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    email = json['email'];
    name = json['name'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['email'] = email;
    data['name'] = name;
    data['address'] = address;
    data['status'] = status;
    return data;
  }
}