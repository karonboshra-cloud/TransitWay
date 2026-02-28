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
      // أحياناً السيرفر بيرجع 200 أو 201 في حالة النجاح
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error in requestReset: $e");
      return false;
    }
  }

  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/verify-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "code": otp,
          "Email": email // تأكد من الـ Case (حرف E كبير) حسب متطلبات السيرفر بتاعك
        }),
      );

      // طباعة الـ Body عشان تعرف لو السيرفر باعت رسالة خطأ معينة
      print("Verify OTP Response: ${response.body}");
      return response.statusCode == 200;
    } catch (e) {
      print("Error in verifyOtp: $e");
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
    } catch (e) {
      print("Error in confirmReset: $e");
      return false;
    }
  }
}