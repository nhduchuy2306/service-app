import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:service_app/models/account_token_model.dart';
import 'package:service_app/models/login_model.dart';

class AccountService {
  static Future<AccountToken> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse("http://192.168.1.122:5000/api/a/auths"),
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
}
