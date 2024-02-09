import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AuthenticationAPI {
  Future<int> signInAPI(
    String mobileNumber,
    String password,
  ) async {
    print(mobileNumber);
    print(password);

    http.Response response = await http.post(
      Uri.parse(
          'https://api.hidayahbooks.hidayahsmart.solutions/v1/user/login'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({
        'mobile_number': mobileNumber,
        'password': password,
      }),
    );
    return response.statusCode;
    print(response.body);
    print(response.statusCode.toString());
  }
}
// 01517033430
// 12345678
