// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:milkmanagement/model/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    var url = Uri.parse("http://api.erp9i.com/api/auth/login");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(url,
        body: jsonEncode(requestModel.toJson()), headers: requestHeaders);

    print('Response status: ${response.statusCode}');
    print('Response body: ${requestModel.toJson()}');
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    }
    else {
      throw Exception('Failed to load data!');
    }
  }
}
