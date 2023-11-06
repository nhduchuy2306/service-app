import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:service_app/models/account_token_model.dart';
import 'package:service_app/models/login_model.dart';
import 'package:service_app/models/register_model.dart';
import 'package:service_app/utils/constant.dart';

class AccountService {
  static Future<AccountToken> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse("${Constant.baseUrlAuth}/a/auths/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(loginModel.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      AccountToken accountToken = AccountToken.fromJson(data);
      return accountToken;
    } else {
      return AccountToken(token: "");
    }
  }

  static Future<bool> register(RegisterModel model) async {
    final response = await http.post(
      Uri.parse("${Constant.baseUrlAuth}/a/auths/register/customer"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
