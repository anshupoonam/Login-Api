// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

class LoginResponseModel {
  final String? token;


  LoginResponseModel({this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",

    );
  }
}


class LoginRequestModel {
  String? login_name;
  String? login_password;

  LoginRequestModel({
    this.login_name,
    this.login_password,
    });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'login_name': login_name?.trim(),
      'login_password': login_password?.trim(),
    };

    return map;
  }
}


