class AccountToken {
  Account? account;
  String? token;

  AccountToken({this.account, this.token});

  AccountToken.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (account != null) {
      data['account'] = account!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Account {
  String? phoneNumber;
  String? role;
  int? accountId;

  Account({this.phoneNumber, this.role, this.accountId});

  Account.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    data['accountId'] = accountId;
    return data;
  }
}
