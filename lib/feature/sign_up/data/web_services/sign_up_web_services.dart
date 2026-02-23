import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transite_way/feature/sign_up/data/models/sign_up_request_body.dart';

class SignUpWebServices {
  static const String _baseUrl = 'http://transit-way.runasp.net/api/Auth/user/register';

  Future<http.Response> signUp(SignUpRequestBody signUpRequestBody) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(signUpRequestBody.toJson()),
    );
    return response;
  }
}
