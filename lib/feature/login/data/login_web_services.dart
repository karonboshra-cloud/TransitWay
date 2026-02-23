import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginWebServices {
  final String baseUrl = "http://transit-way.runasp.net";

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Invalid email or password";
      }
    } catch (e) {
      if (e.toString() == "Invalid email or password") {
        rethrow;
      }
      throw "Check your internet connection and try again";
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle(String idToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/google-login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'idToken': idToken,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Google authentication failed on server";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}