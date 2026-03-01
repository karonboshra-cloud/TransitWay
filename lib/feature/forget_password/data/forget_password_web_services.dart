import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgetPasswordWebServices {
  final String baseUrl = "http://transit-way.runasp.net";

  // 1. البحث عن الإيميل الحقيقي باستخدام رقم الموبايل
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
    } catch (e) {
      print("Error in getEmailByPhone: $e");
      return null;
    }
  }

  // 2. دالة إخفاء الإيميل (أول حرف وآخر حرفين)
  String maskEmail(String email) {
    final parts = email.split('@');
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 3) return email;
    return "${name[0]}${'*' * (name.length - 3)}${name.substring(name.length - 2)}@$domain";
  }

  // 3. طلب إرسال الرمز (OTP) للإيميل
  Future<bool> requestReset(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/request-reset'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      // النجاح قد يكون 200 أو 201
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error in requestReset: $e");
      return false;
    }
  }

  // 4. التحقق من الرمز (OTP)
  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Auth/verify-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "code": otp,
          "Email": email // تأكد من الـ Case (حرف E كبير)
        }),
      );

      print("Verify OTP Response: ${response.body}");
      return response.statusCode == 200;
    } catch (e) {
      print("Error in verifyOtp: $e");
      return false;
    }
  }

  // 5. تعيين كلمة المرور الجديدة
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