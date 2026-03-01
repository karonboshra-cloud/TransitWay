import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgetPasswordWebServices {
  final String baseUrl = "http://transit-way.runasp.net";

  Future<String?> getEmailByPhone(String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/get-email-by-phone'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['email'];
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  String maskEmail(String email) {
    final parts = email.split('@');
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 3) return email;
    return "${name[0]}${'*' * (name.length - 3)}${name.substring(name.length - 2)}@$domain";
  }

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
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
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
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}