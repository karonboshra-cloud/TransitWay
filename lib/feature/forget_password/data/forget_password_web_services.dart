import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgetPasswordWebServices {
  final String baseUrl = "http://transit-way.runasp.net";

  Future<bool> requestReset(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/request-reset'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> verifyOtp({required String email, required String otp}) async {
    return true;
  }

  Future<bool> confirmReset(String email, String code, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/confirm-reset'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'code': code,
          'newPassword': newPassword,
        }),
      );

      print("Confirm Reset Response: ${response.statusCode} - ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Confirm Reset Error: $e");
      return false;
    }
  }
}